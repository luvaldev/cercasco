#include "esp_camera.h"
#include <WiFi.h>
#include <esp_now.h>
#include "FS.h"
#include "SD_MMC.h"

#define PWDN_GPIO_NUM     32
#define RESET_GPIO_NUM    -1
#define XCLK_GPIO_NUM      0
#define SIOD_GPIO_NUM     26
#define SIOC_GPIO_NUM     27
#define Y9_GPIO_NUM       35
#define Y8_GPIO_NUM       34
#define Y7_GPIO_NUM       39
#define Y6_GPIO_NUM       36
#define Y5_GPIO_NUM       21
#define Y4_GPIO_NUM       19
#define Y3_GPIO_NUM       18
#define Y2_GPIO_NUM        5
#define VSYNC_GPIO_NUM    25
#define HREF_GPIO_NUM     23
#define PCLK_GPIO_NUM     22
#define FLASH_GPIO_NUM     4

bool cameraOk = false;
bool sdCardOk = false;

typedef struct struct_message {
    float distance;
    int   alert_level;
} struct_message;

struct_message rcv_msg;

bool initCamera() {
  camera_config_t config;
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sscb_sda = SIOD_GPIO_NUM;
  config.pin_sscb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 20000000;
  config.pixel_format = PIXFORMAT_JPEG;

  config.frame_size = FRAMESIZE_VGA;   // FRAMESIZE_VGA es 640x480
  config.jpeg_quality = 12;
  config.fb_count = 1;

  esp_err_t err = esp_camera_init(&config);
  if (err != ESP_OK) {
    Serial.printf("Error al inicializar cámara: 0x%x\n", err);
    return false;
  }
  
  Serial.println("Cámara inicializada correctamente.");
  return true;
}

bool initSDCard() {
  Serial.println("Iniciando tarjeta SD (modo 1-bit)...");

  if (!SD_MMC.begin()) {
    Serial.println("Error al montar tarjeta SD");
    return false;
  }
  
  uint8_t cardType = SD_MMC.cardType();
  if (cardType == CARD_NONE) {
    Serial.println("No se detectó tarjeta SD");
    return false;
  }

  Serial.println("Tarjeta SD inicializada.");

  if (!SD_MMC.exists("/CAPTURES")) {
    SD_MMC.mkdir("/CAPTURES");
    Serial.println("Directorio /CAPTURES creado");
  }
  if (!SD_MMC.exists("/CAPTURES/ALERTA")) {
    SD_MMC.mkdir("/CAPTURES/ALERTA");
    Serial.println("Directorio /CAPTURES/ALERTA creado");
  }
  
  return true;
}

void takeAndSavePhoto(int alert_level) {
  String path = "/CAPTURES/ALERTA/NIVEL_" + String(alert_level);
  
  if (!SD_MMC.exists(path)) {
    SD_MMC.mkdir(path.c_str());
    Serial.println("Directorio creado: " + path);
  }

  digitalWrite(FLASH_GPIO_NUM, HIGH);
  delay(100);
  camera_fb_t * fb = esp_camera_fb_get();
  digitalWrite(FLASH_GPIO_NUM, LOW);
  
  if (!fb) {
    Serial.println("Error en la captura de la foto");
    return;
  }

  String filename = path + "/" + String(millis()) + ".jpg";
  File file = SD_MMC.open(filename.c_str(), FILE_WRITE);

  if (!file) {
    Serial.println("Error al abrir el archivo para escritura");
  } else {
    file.write(fb->buf, fb->len);
    Serial.println("Foto guardada: " + filename);
    file.close();
  }
  esp_camera_fb_return(fb);
}

// --- Callback: Función que se ejecuta al recibir un mensaje ESP-NOW ---

void OnDataRecv(const esp_now_recv_info_t * mac_info, const uint8_t *incomingData, int len) {
  memcpy(&rcv_msg, incomingData, sizeof(rcv_msg));
  
  Serial.print("\r\nMensaje recibido de: ");
  // Imprimir la MAC del remitente
  for (int i = 0; i < 6; i++) {
    Serial.printf("%02X", mac_info->src_addr[i]);
    if (i < 5) Serial.print(":");
  }
  
  Serial.print(" | Distancia: ");
  Serial.print(rcv_msg.distance);
  Serial.print(" cm, Nivel: ");
  Serial.println(rcv_msg.alert_level);

  // Si la alerta no es "Nivel 1" (sin alerta), tomar foto
  if (rcv_msg.alert_level > 1) {
    
    // Solo proceder si la cámara y la SD están listas
    if (cameraOk && sdCardOk) {
      Serial.println("¡Alerta detectada! Tomando foto...");
      takeAndSavePhoto(rcv_msg.alert_level);
    } else {
      Serial.println("No se puede tomar foto. Cámara o SD no están listas.");
    }
  } else {
    Serial.println("Nivel 1 (sin alerta), no se toma foto.");
  }
}

// --- Función para inicializar ESP-NOW ---
void initEspNow() {
  WiFi.disconnect();
  WiFi.mode(WIFI_STA); // Modo Estación para recibir
  
  if (esp_now_init() != ESP_OK) {
    Serial.println("Error al inicializar ESP-NOW");
    return;
  }
  
  // Registrar el callback de recepción
  esp_now_register_recv_cb(OnDataRecv);
  Serial.println("ESP-NOW inicializado como receptor.");
}


void setup() {
  Serial.begin(115200);
  Serial.println("\n\n--- Iniciando ESP32-CAM (Receptor de Alertas) ---");

  // Configurar el pin del flash como salida y apagarlo
  pinMode(FLASH_GPIO_NUM, OUTPUT);
  digitalWrite(FLASH_GPIO_NUM, LOW);

  // Inicializar hardware
  cameraOk = initCamera();
  sdCardOk = initSDCard();

  // Inicializar comunicación
  initEspNow();

  // Imprimir la dirección MAC de esta ESP32-CAM.
  // copiar esta dirección en el archivo 'private.h'.
  Serial.print("\n\nDirección MAC de esta ESP32-CAM: ");
  Serial.println(WiFi.macAddress());
  
  Serial.println("\n--- Sistema listo. Esperando alertas. ---");
}

void loop() {
  delay(1000);
}
