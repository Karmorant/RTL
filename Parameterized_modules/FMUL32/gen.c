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


        FILE *fp_arg1 = fopen("arg_1.txt", "w");
        FILE *fp_arg2 = fopen("arg_2.txt", "w");
        FILE *fp_res  = fopen("res.txt", "w");




        for(int i = 0; i < 1000000; i++) {

                uint32_t single32_1 = (uint32_t)rand();
                uint32_t single32_2 = (uint32_t)rand();

                fprintf(fp_arg1, "%08X\n", single32_1);
                fprintf(fp_arg2, "%08X\n", single32_2);



                float numf_1 = single32_to_float(single32_1);
                float numf_2 = single32_to_float(single32_2);

                float fl_res = numf_1 * numf_2;
                uint32_t single32_res = float_to_single32(fl_res);
                fprintf(fp_res, "%08X\n", single32_res);
                srand(time(NULL) + i + 1);

        }

        fclose(fp_arg1);
        fclose(fp_arg2);
        fclose(fp_res);

        return 0;
}