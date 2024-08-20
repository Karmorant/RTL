#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

typedef union {
    float f;
    uint32_t u;
} FloatUnion;


void print_binary_2arg(uint32_t n_1, uint32_t n_2, FILE *fp) {
    for (int i = 31; i >= 0; i--) {
        int bit_1 = (n_1 >> i) & 1;
        if (i == 31) {
                fprintf(fp, "op1 <= 32'b%d", bit_1);
        }
        else if (i > 0) {
                fprintf(fp, "%d", bit_1);
        }
        else {
                fprintf(fp, "%d;\n", bit_1);
        }
    }
    for (int j = 31; j >= 0; j--) {
        int bit_2 = (n_2 >> j) & 1;
        if (j == 31) {
                fprintf(fp, "op2 <= 32'b%d", bit_2);
        }
        else if (j > 0) {
                fprintf(fp, "%d", bit_2);
        }
        else {
                fprintf(fp, "%d;\n#4;\n", bit_2);
        }
    }    
}


void print_binary(uint32_t n_1, FILE *fp) {
    for (int i = 31; i >= 0; i--) {
        int bit_1 = (n_1 >> i) & 1;
        if (i == 31) {
                fprintf(fp, "res_eth <= 32'b%d", bit_1);
        }
        else if (i > 0) {
                fprintf(fp, "%d", bit_1);
        }
        else {
                fprintf(fp, "%d;\n#4;\n", bit_1);
        }
    }
}


uint32_t float_to_single32(float f) {
    FloatUnion fu;
    fu.f = f;
    return fu.u;
}

float single32_to_float(uint32_t u) {
        FloatUnion fu;
        fu.u = u;
        return fu.f;
}


int main() {

        srand(time(NULL));


        FILE *fp = fopen("tests.txt", "w");
        FILE *fp_res = fopen("res_eth.txt", "w");

        uint32_t single32_1 = 0x2E893282;        
        uint32_t single32_2 = 0x759241CC;


        float numf_1 = single32_to_float(single32_1);
        float numf_2 = single32_to_float(single32_2);

        //float numf_1 = -0.34782;
        //float numf_2 = 9238123;
        float fl_res = numf_1 * numf_2;

        //uint32_t single32_1 = float_to_single32(numf_1);        
        //uint32_t single32_2 = float_to_single32(numf_2);

        // for(int i = 0; i < 1000; i++) {

        //         uint32_t single32_1 = (uint32_t)rand();
        //         uint32_t single32_2 = (uint32_t)rand();

        //         float numf_1 = single32_to_float(single32_1);
        //         float numf_2 = single32_to_float(single32_2);

        //         float fl_res = numf_1 * numf_2;
        //         uint32_t single32_res = float_to_single32(fl_res);

        //         srand(time(NULL) + i + 1);
        //         printf("Число в формате SINGLE32 %d: 0x%08X\n", i, single32_res);
        //         print_binary(single32_res, fp_res);
        //         print_binary_2arg(single32_1, single32_2, fp);
        // }
        uint32_t single32_res = float_to_single32(fl_res);
    

        printf("%f\n", numf_1);
        printf("%f\n", numf_2);

        printf("Число в формате SINGLE32 (IEEE 754): 0x%08X\n", single32_res);


        printf("Двоичный формат:\n");
        fclose(fp);

        return 0;
}