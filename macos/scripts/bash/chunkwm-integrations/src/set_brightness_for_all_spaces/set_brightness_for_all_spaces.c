#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define CONFIG_FILE_PATH "/Users/andrew/.config/chunkwm/space_brightness"
#define CONFIG_FILE_TEST_PATH "/Users/andrew/.config/chunkwm/space_brightness.test"
#define SPACE_LABELS "qwertasdfgzxcvb"
#define SPACE_LABEL_SIZE sizeof(SPACE_LABELS[0])
#define SPACE_LABELS_LENGTH sizeof(SPACE_LABELS)/SPACE_LABEL_SIZE

#define DEFAULT_BRIGHTNESS 0.5
#define MIN_BRIGHTNESS 0
#define MAX_BRIGHTNESS 1

#define BRIGHTNESS_ARGUMENT_MAX_LENGTH 4

void clear_brightness_file();
int read_brightness_file();
int write_brightness_file(char *brightness_value);
char* extract_brightness_argument(int argc, char **argv, char* buffer);

int main(int argc, char **argv) {
  int result;
  char new_brightness[BRIGHTNESS_ARGUMENT_MAX_LENGTH+1];
  extract_brightness_argument(argc, argv, new_brightness);

  result = write_brightness_file(new_brightness);
  return !result;
}

int read_brightness_file() {
  FILE *file_pointer;
  char *buffer;
  long numbytes;

  file_pointer = fopen(CONFIG_FILE_PATH, "r");

  if (file_pointer == NULL) {
    fprintf(stderr, "Can't open input file in.list!\n");
    return 0;
  }
  fseek(file_pointer, 0L, SEEK_END);

  numbytes = ftell(file_pointer);

  fseek(file_pointer, 0L, SEEK_SET);

  buffer = (char*)calloc(numbytes, sizeof(char));

  fread(buffer, sizeof(char), numbytes, file_pointer);

  fclose(file_pointer);

  printf("%s", buffer);

  return 1;
}

int write_brightness_file(char *brightness_value) {
  unsigned long i;
  FILE *file_pointer;

  clear_brightness_file();

  file_pointer = fopen(CONFIG_FILE_TEST_PATH, "a");

  if (file_pointer == NULL) {
    fprintf(stderr, "Can't open output file.\n");
    exit(1);
  }

  for(i = 0; i < SPACE_LABELS_LENGTH -1; i++)
  {
    fprintf(file_pointer, "%c=%s\n", SPACE_LABELS[i], brightness_value);
  }

  fclose(file_pointer);

  return 1;
}

void clear_brightness_file() {
  FILE *file_pointer;
  file_pointer = fopen(CONFIG_FILE_TEST_PATH, "w");

  if (file_pointer == NULL) {
    fprintf(stderr, "Can't open output file.\n");
    exit(1);
  }

  fprintf(file_pointer, "");
  fclose(file_pointer);
}

char* extract_brightness_argument(int argc, char **argv, char* buffer) {
  if (argc > 1) {
    if (strlen(argv[1]) <= BRIGHTNESS_ARGUMENT_MAX_LENGTH) {
      float brightness_f = atof(argv[1]);
      if (isdigit(brightness_f)) {
        if (brightness_f >= 0.0 && brightness_f <= 1.0) {
          strcpy(buffer, argv[1]);
        } else {
          printf("Brightness must be between %d and %d, but %f.8 was provided", MIN_BRIGHTNESS, MAX_BRIGHTNESS, brightness_f);
          exit(1);
        }
      } else {
        printf("Argument `%s` must be numeric.", argv[1]);
        exit(1);
      }
    } else {
      printf("Exceeded max brightness arg length: %d", BRIGHTNESS_ARGUMENT_MAX_LENGTH);
      exit(1);
    }
  } else {
    printf("Setting default brightness value: %f", DEFAULT_BRIGHTNESS);
    snprintf(buffer, 4, "%f", DEFAULT_BRIGHTNESS);
  }
  return buffer;
}
