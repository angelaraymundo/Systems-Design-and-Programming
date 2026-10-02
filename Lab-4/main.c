#include <stdio.h>
#include <stdlib.h>

// indicating that the assembly function exists in another file
extern int sum_array(int *array, int count); 

int main(int argc, char *argv[]) {
    // Ensuring that the text file is passed in the command line
    if (argc != 2) {
        printf("Usage: %s <data_file.txt>\n", argv[0]);
        return 1;
    }

    // Opening file in read mode
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error opening file.\n");
        return 1;
    }

    int count;
    // Read the very first line to find out how many numbers there are (and check for errors)
    if (fscanf(file, "%d", &count) != 1) {
        printf("Error reading count.\n");
        fclose(file);
        return 1;
    }

    // Dynamically allocating memory for the array
    int *array = (int *)malloc(count * sizeof(int));
    if (array == NULL) {
        printf("Memory allocation failed.\n");
        fclose(file);
        return 1;
    }

    // loop throught the rest of the file to populate the array
    for (int i = 0; i < count; i++) {
        fscanf(file, "%d", &array[i]);
    }
    fclose(file); //close file

    // calling assembly function, %rdi receives 'array', %rsi receives 'count'
    int sum = sum_array(array, count);

    //Print final result returned in %eax
    printf("The sum of the integers is: %d\n", sum);

    // Clean up memory to avoid memory leaks
    free(array);
    
    return 0;
}