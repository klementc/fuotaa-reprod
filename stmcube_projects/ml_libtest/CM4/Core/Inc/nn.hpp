/*
 * nn.h
 *
 *  Created on: Oct 30, 2024
 *      Taken from: https://github.com/SoufianeAatab/EMLlib/blob/master/nn.h
 */

#ifndef INC_NN_HPP_
#define INC_NN_HPP_


//#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
//#include <chrono>
#include <stdint.h>
#include <stddef.h>

#define USEMOMENTUM 1
#define MOMENTUM 0.9
#define MEMORY_ARENA_SIZE 1024*25
#define MEMORY_SCRATCH_SIZE 4*32


typedef uint8_t u8;
typedef uint16_t u16;
//typedef uint32_t uint32_t;
typedef uint64_t u64;

typedef int8_t i8;
typedef int16_t i16;
typedef int32_t i32;
typedef int64_t i64;

typedef float f32;
typedef double f64;

typedef uint32_t bool32;

struct memory_arena
{
    size_t Used;
    size_t Size;
    uint32_t *Base;
};

static memory_arena MemoryArena = {};
static memory_arena MemoryScratch = {};
i8 arr[MEMORY_ARENA_SIZE];
i8 arr2[MEMORY_SCRATCH_SIZE];

inline void *PushSize(memory_arena *Arena, size_t SizeToReserve)
{
	//printf("Arenasize %d used %d reserve %d\r\n", Arena->Size, Arena->Used, SizeToReserve);
    assert(Arena->Used + SizeToReserve <= Arena->Size);
    void *Result = Arena->Base + Arena->Used;
    Arena->Used += SizeToReserve;
    return (void *)Result;
}

void InitMemory()
{
    MemoryArena.Base = (uint32_t*) arr;
    MemoryArena.Size = MEMORY_ARENA_SIZE;
    MemoryArena.Used = 0;

    MemoryScratch.Base = (uint32_t*) arr2;
    MemoryScratch.Size = MEMORY_SCRATCH_SIZE;
    MemoryScratch.Used = 0;
}

static f32 randLowVal = 0;
static f32 randHighVal = 0;

f32 uniform_randf(){
    float num = (float)(rand()%1001) / 1000.0 - randLowVal;
    return num;
}

int8_t uniform_rand(){
    int8_t num = (rand()%1001);
    return num;
}

class M
{
public:
    u8 *data;
    uint32_t rows;
    uint32_t cols;

    M(u8 *data, uint32_t rows, uint32_t cols) : data(data), rows(rows), cols(cols) {}

    static M ones(uint32_t rows, uint32_t cols)
    {
    	u8 *data = (u8 *)PushSize(&MemoryArena, rows * cols * sizeof(u8));
        M o(data, rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            o.data[i] = 1;
        }
        return o;
    }

    static M zeros(uint32_t rows, uint32_t cols)
    {
    	u8 *data = (u8 *)PushSize(&MemoryArena, rows * cols * sizeof(u8));
        M o(data, rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            o.data[i] = 0; //0.0f;
        }
        return o;
    }

    static M zerosScratch(uint32_t rows, uint32_t cols)
    {
    	//printf("Scratch for size: %lu x %lu\r\n", rows, cols);
    	u8 *data = (u8 *)MemoryScratch.Base;;
        M o(data, rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            o.data[i] = 0; //0.0f;
        }
        return o;
    }


    static M rand(uint32_t rows, uint32_t cols)
    {
    	u8 *data = (u8 *)PushSize(&MemoryArena, rows * cols * sizeof(u8));
        M o(data, rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            o.data[i] = uniform_rand();
        }
        return o;
    }

    void shape()
    {
        printf("Shape: (%lu, %lu)\r\n", rows, cols);
    }

    void print()
    {
        //	this->shape();
        for (uint32_t i = 0; i < rows; ++i)
        {
            for (uint32_t j = 0; j < cols; ++j)
            {
                printf("%u ", data[i * cols + j]);
            }
            printf("\r\n");
        }
    }

    void transpose()
    {
        if (cols != 1)
        {
            uint32_t aux = cols;
            cols = rows;
            rows = aux;
        }
    }

    u8 &operator[](uint32_t idx)
    {
        return data[idx];
    }

    M operator-(M B)
    {
        M out = M::zeros(rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            out.data[i] = data[i] - B.data[i];
        }
        return out;
    }

    M &operator*=(f32 v)
    {
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            data[i] = data[i] * v;
        }
        return *this;
    }

    M &operator+=(M v)
    {
        assert(this->cols == v.cols && this->rows == v.rows);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            data[i] = data[i] + v.data[i];
        }
        return *this;
    }

    M &operator-=(M v)
    {
        assert(this->cols == v.cols && this->rows == v.rows);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            data[i] -= v.data[i];
        }
        return *this;
    }

    M operator/(M B)
    {
        M out = M::zeros(rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            out.data[i] = data[i] * (1.0f / B.data[i]);
        }
        return out;
    }

    M operator*(M B)
    {
        assert(B.rows == rows && B.cols == cols);
        M out = M::zeros(rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            out.data[i] = data[i] * B.data[i];
        }
        return out;
    }

    M operator+(M B)
    {
        assert(B.rows == rows && B.cols == cols);
        M out = M::zeros(rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            out.data[i] = data[i] + B.data[i];
        }
        return out;
    }

    M operator*(float B)
    {
        M out = M::zeros(rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            out.data[i] = data[i] * B;
        }
        return out;
    }

    void add(M b)
    {
        assert(rows == b.rows && cols == b.cols);
        for (uint32_t i = 0; i < b.rows * b.cols; ++i)
        {
            this->data[i] += b.data[i];
        }
    }

    void sub(M b)
    {
        assert(rows == b.rows && cols == b.cols);
        for (uint32_t i = 0; i < b.rows * b.cols; ++i)
        {
            this->data[i] -= b.data[i];
        }
    }

    float sum()
    {
        f32 s = 0.0f;
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            s += data[i];
        }
        return s;
    }

    float mean()
    {
        return (this->sum() / cols);
    }

    f32 std(){
        f32 sum = 0.0f;
        uint32_t n = rows * cols;
        for (uint32_t i = 0; i < n; ++i)
        {
            sum += data[i];
        }

        f32 mean = sum / n;
        f32 sd = 0.0f;
        for(uint32_t i = 0; i < n; i++) {
            sd += pow(data[i] - mean, 2);
        }

        return sqrt(sd / (f32)n);
    }

    uint32_t argmax()
    {
        uint32_t imax = 0;
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            if (data[i] > data[imax])
            {
                imax = i;
            }
        }

        return imax;
    }

    M square()
    {
        M out = M::zeros(rows, cols);
        for (uint32_t i = 0; i < rows * cols; ++i)
        {
            out.data[i] = data[i] * data[i];
        }
        return out;
    }

    static M MatMul(M A, M B)
    {
        assert(A.cols == B.rows);
        M Out = M::zeros(A.rows, B.cols);
        for (uint32_t i = 0; i < A.rows; i++)
        {
            for (uint32_t j = 0; j < B.cols; j++)
            {
                Out.data[i * B.cols + j] = 0;
                for (uint32_t k = 0; k < A.cols; k++)
                {
                    Out.data[i * B.cols + j] += A.data[i * A.cols + k] * B.data[k * B.cols + j];
                }
            }
        }
        return Out;
    }

    static void MatMul_(M A, M B, M &Out)
    {
        for (uint32_t i = 0; i < A.rows; i++)
        {
            for (uint32_t j = 0; j < B.cols; j++)
            {
                Out.data[i * B.cols + j] = 0;
                for (uint32_t k = 0; k < A.cols; k++)
                {
                    Out.data[i * B.cols + j] += A.data[i * A.cols + k] * B.data[k * B.cols + j];
                }
            }
        }
    }

};

struct M4{
    u8* data;
    uint32_t d1;
    uint32_t d2;
    uint32_t d3;
    uint32_t d4;

    M4() = default;
    M4(u8* data, uint32_t d1, uint32_t d2, uint32_t d3, uint32_t d4): data(data), d1(d1), d2(d2), d3(d3), d4(d4){}
    static M4 ones(uint32_t d1, uint32_t d2, uint32_t d3, uint32_t d4)
    {
    	u8 *data = (u8 *)PushSize(&MemoryArena, d1*d2*d3*d4 * sizeof(u8));
        M4 o(data, d1, d2, d3, d4);
        for (uint32_t i = 0; i < d1*d2*d3*d4; ++i)
        {
            o.data[i] = 1.0f;
        }
        return o;
    }

    static M4 zeros(uint32_t d1, uint32_t d2, uint32_t d3, uint32_t d4)
    {
    	u8 *data = (u8 *)PushSize(&MemoryArena, d1*d2*d3*d4 * sizeof(u8));
        M4 o(data, d1, d2, d3, d4);
        for (uint32_t i = 0; i < d1*d2*d3*d4; ++i)
        {
            o.data[i] = 0.0f;
        }
        return o;
    }

    static M4 rand(uint32_t d1, uint32_t d2, uint32_t d3, uint32_t d4)
    {
    	u8 *data = (u8 *)PushSize(&MemoryArena, d1*d2*d3*d4 * sizeof(u8));
        M4 o(data, d1, d2, d3, d4);
        for (uint32_t i = 0; i < d1*d2*d3*d4; ++i)
        {
            //o.data[i] = uniform_rand();
        }
        return o;
    }

    M4 &operator-=(M4 v)
    {
        assert(this->d1 == v.d1 && this->d2 == v.d2 && this->d3 == v.d3 && this->d4 == v.d4);
        for (uint32_t i = 0; i < d1 * d2*d3*d4; ++i)
        {
            data[i] -= v.data[i];
        }
        return *this;
    }

    M4 operator*(u8 lr)
    {
        M4 output = M4::zeros(d1,d2,d3,d4);
        for (uint32_t i = 0; i < d1 * d2*d3*d4; ++i)
        {
            output.data[i] = data[i] * lr;
        }
        return output;
    }

    f32 operator()(uint32_t l, uint32_t k, uint32_t j, uint32_t i){
        //assert(i < d1 && j < d2 && k < d3 && l < d4);
        uint32_t index = l * (d4*d2*d3) + k * (d4*d3) + j*d4 + i;
        return data[index];
    }

    void set(uint32_t l, uint32_t k, uint32_t j, uint32_t i, f32 val){
        //assert(i < d1 && j < d2 && k < d3 && l < d4);

        uint32_t index = l * (d4*d2*d3) + k * (d4*d3) + j*d4 + i;
        data[index] = val;
    }

    void add(uint32_t l, uint32_t k, uint32_t j, uint32_t i, f32 val){
        uint32_t index = l * (d4*d2*d3) + k * (d4*d3) + j*d4 + i;
        data[index] += val;
    }

    M operator()(uint32_t i, uint32_t j){
        uint32_t index = i * (d2*d3*d4) + j*(d3*d4);
        M o = M(data+index, d3, d4);
        return o;
    }


    M4 operator+(M4 B)
    {
        M4 out = M4::zeros(d1, d2, d3, d4);
        for (uint32_t i = 0; i < d1 * d2 * d3 * d4; ++i)
        {
            out.data[i] = data[i] + B.data[i];
        }
        return out;
    }

    f32 std(){
        f32 sum = 0.0f;
        uint32_t n = d1 * d2 * d3 * d4;
        for (uint32_t i = 0; i < d1 * d2 * d3 * d4; ++i)
        {
            sum += data[i];
        }

        f32 mean = sum / n;
        f32 sd = 0.0f;
        for(uint32_t i = 0; i < d1 * d2 * d3 * d4; i++) {
            sd += pow(data[i] - mean, 2);
        }

        return sqrt(sd / (f32)n);
    }

    void print(){
        printf("SHAPE: %lu, %lu, %lu, %lu\n",d1,d2,d3,d4 );

        for(uint32_t i=0;i<d1;++i){
            printf("[\n");
            for(uint32_t j=0;j<d2;++j){
                printf("[\n");
                for(uint32_t k=0;k<d3;++k){
                    printf("[");
                    for(uint32_t l=0;l<d4;++l){
                        uint32_t index = i * (d4*d2*d3) + j * (d4*d3) + k*d4 + l;
                        //uint32_t index = i * (d4*d2*d3) + j * (d4*d3) + k*d4 + l;
                        printf("%u, ",data[index]);
                    }
                    printf("],\n");
                }
                printf("],\n");
            }
            printf("]\n");
        }
    }
};

M4 operator*(f32 scalar, M4 rhs)
{
    M4 output = M4::zeros(rhs.d1,rhs.d2,rhs.d3,rhs.d4);
    for (uint32_t i = 0; i < rhs.d1 * rhs.d2*rhs.d3*rhs.d4; ++i)
    {
        output.data[i] = rhs.data[i] * scalar;
    }
    return output;
}

M4 operator-(M4 lhs, M4 rhs)
{
    //assert();
    M4 output = M4::zeros(rhs.d1,rhs.d2,rhs.d3,rhs.d4);
    for (uint32_t i = 0; i < rhs.d1 * rhs.d2*rhs.d3*rhs.d4; ++i)
    {
        output.data[i] = lhs.data[i] - rhs.data[i];
    }
    return output;
}

M operator*(f32 scalar, M rhs)
{
    M output = M::zeros(rhs.rows,rhs.cols);
    for (uint32_t i = 0; i < rhs.rows * rhs.cols; ++i)
    {
        output.data[i] = rhs.data[i] * scalar;
    }
    return output;
}


#define MT_N 624
#define MT_M 397

typedef struct {
    unsigned int mt[MT_N];
    int index;
} mt_state;
mt_state mystate;
void mt_seed(mt_state *state, unsigned int seed) {
    state->mt[0] = seed;
    for (int i = 1; i < MT_N; i++) {
        state->mt[i] = 1812433253 * (state->mt[i-1] ^ (state->mt[i-1] >> 30)) + i;
    }
    state->index = MT_N;
}

void mt_twist(mt_state *state) {
    static const unsigned int MAG01[2] = {0, 0x9908b0df};
    unsigned int y;

    for (int i = 0; i < MT_N; i++) {
        y = (state->mt[i] & 0x80000000) | (state->mt[(i+1) % MT_N] & 0x7fffffff);
        state->mt[i] = state->mt[(i + MT_M) % MT_N] ^ (y >> 1) ^ MAG01[y & 0x1];
    }
    state->index = 0;
}

unsigned int mt_rand(mt_state *state) {
    if (state->index >= MT_N) {
        mt_twist(state);
    }
    unsigned int y = state->mt[state->index++];
    y ^= (y >> 11);
    y ^= (y << 7) & 0x9d2c5680;
    y ^= (y << 15) & 0xefc60000;
    y ^= (y >> 18);
    return y;
}

double mt_rand_double(mt_state *state) {
    return (double)mt_rand(state) / (double)0xffffffff;
}

f32 clip_by_value(f32 val, f32 min, f32 max){
    if (val > max){
        return max;
    }
    if(val < min){
        return min;
    }

    return val;
}

// Computes the derivative of the mean squared error (MSE) loss with respect to 'y_hat'
inline M MsePrime(M y, M y_hat)
{
    return y_hat - y;
}

// Computes the mean squared error (MSE) loss between two matrices 'y' and 'y_hat'
inline f32 Mse(M y, M y_hat)
{
    return (y - y_hat).square().mean();
}

// Softmax function calculates the probability of each output for a given input matrix
M Softmax(M X)
{
    f32 sum = 0.0f;
    f32 max = X.data[X.argmax()];
    M out = M::zeros(X.rows, X.cols);
    for (uint32_t i = 0; i < X.cols; ++i)
    {
        sum += exp(X.data[i] - max);
    }
    for (uint32_t i = 0; i < X.cols; ++i)
    {
        // subtract max to avoid NaN/+inf errors
        out.data[i] = exp(X.data[i] - max) / sum;
    }
    return out;
}

// SoftmaxPrime function calculates the derivative of the softmax function
M SoftmaxPrime(M X)
{
    M Out = M::zeros(X.cols, X.cols);
    // calculate the derivative of the softmax function
    for (uint32_t i = 0; i < X.cols; ++i)
    {
        for (uint32_t j = 0; j < X.cols; ++j)
        {
            if (i == j)
            {
                Out.data[i * X.cols + j] = X.data[i] * (1.0f - X.data[i]);
            }
            else
            {
                Out.data[i * X.cols + j] = -X.data[i] * X.data[j];
            }
        }
    }
    return Out;
}

M Sigmoid(M X)
{
    uint32_t Cols = X.cols;
    uint32_t Rows = X.rows;
    for (uint32_t i = 0; i < Rows * Cols; ++i)
    {
        X.data[i] = 1.0f / (1.0f + exp(-X.data[i]));
    }
    return X;
}

M SigmoidPrime(M X)
{
    M Out = M::zeros(X.rows, X.cols);
    for (uint32_t i = 0; i < X.rows * X.cols; ++i)
    {
        Out.data[i] = X.data[i] * (1.0f - X.data[i]);
    }
    return Out;
}


M Relu(M X)
{
    M Out = M::zeros(X.rows, X.cols);
    for (uint32_t i = 0; i < X.rows * X.cols; ++i)
    {
        Out.data[i] = X.data[i] > 0.0f ? X.data[i] : 0.0f;
    }
    return Out;
}

M ReluPrime(M X)
{
    M Out = M::zeros(X.rows, X.cols);
    for (uint32_t i = 0; i < X.rows * X.cols; ++i)
    {
        Out.data[i] = X.data[i] > 0.0f ? 1.0 : 0.0f;
    }
    return Out;
}

M Tanh(M X)
{
    M Out = M::zerosScratch(X.rows, X.cols);
    for (uint32_t i = 0; i < X.rows * X.cols; ++i)
    {
        Out.data[i] = tanh(X.data[i]);
    }
    return Out;
}

M TanhPrime(M X)
{
    M Out = M::zeros(X.rows, X.cols);
    for (uint32_t i = 0; i < X.rows * X.cols; ++i)
    {
        Out.data[i] = (1 - X.data[i] * X.data[i]);
    }
    return Out;
}

void setRandomUniform(double low, double high)
{
        randLowVal = low;
        randHighVal = high;
}

struct Layer
{
    // Weight and bias matrices
    M w;
    M b;

    // Gradient and biases weights matrices
    M dw;
    M db;

    M vdw;
    M vdb;

    // Factory function to create a new layer object
    static Layer *create(uint32_t input_size, uint32_t output_size)
    {
        // Allocate memory for the layer on the memory arena
        Layer *l = (Layer *)PushSize(&MemoryArena, sizeof(Layer));

        // Initialize the weight and bias matrices with random values
        l->w = M::rand(input_size, output_size);
        l->b = M::zeros(1, output_size);

        // Initialize the gradient matrices to zero
        l->dw = M::zeros(input_size, output_size);
        l->db = M::zeros(1, output_size);

        // // Initialize the momentum matrices to zero
        l->vdw = M::zeros(input_size, output_size);
        l->vdb = M::zeros(1, output_size);
        return l;
    }

    // Forward propagation function
    M forward(M x)
    {
        // Check that the input matrix has the correct number of columns, this saves us from stupid bugs.
    	//printf("X.cols: %lu, w.rows: %lu\r\n", x.cols, w.rows);
        assert(x.cols == w.rows);
        M Out = M::zerosScratch(x.rows, w.cols);
        for (uint32_t i = 0; i < w.cols; ++i)
        {
            f32 accum = 0;
            for (uint32_t j = 0; j < x.cols; ++j)
            {
                accum += x.data[j] * w.data[j * w.cols + i];
            }
            Out.data[i] = accum + b.data[i];
        }
        return Out;
    }

    // Backward propagation function
    M backward(M grad)
    {
        // Check that the gradient matrix has the correct number of columns
        assert(grad.cols == w.cols);
        M out = M::zeros(1, w.rows);
        for (uint32_t k = 0; k < w.rows; ++k)
        {
            for (uint32_t l = 0; l < grad.cols; ++l)
            {
                out.data[k] += grad.data[l] * w.data[k * w.cols + l];
            }
        }
        return out;
    }

    // Function to reset the gradient matrices to zero
    void resetGradients()
    {
        this->dw = M::zeros(this->dw.rows, this->dw.cols);
        this->db = M::zeros(1, this->db.cols);
    }

    // Function to calculate the weights matrix gradients, using the input gradient and the activation function of the current layer
    M getDelta(M grads, M a)
    {
        assert(w.rows == a.cols);
        M out = M::zeros(w.rows, w.cols);
        for (uint32_t i = 0; i < w.rows; ++i)
        {
            for (uint32_t j = 0; j < w.cols; ++j)
            {
                f32 g = grads.data[j];
                out.data[i * w.cols + j] = g * a.data[i];
            }
        }
        return out;
    }

    void setDelta(M grads, M a)
    {
        assert(w.rows == a.cols);
        for (uint32_t i = 0; i < w.rows; ++i)
        {
            for (uint32_t j = 0; j < w.cols; ++j)
            {
                f32 g = grads.data[j];
                dw.data[i * w.cols + j] = g * a.data[i];
            }
            db.data[i] = grads.data[i];
        }

    }

    void print()
    {
    	printf("Weights matrix: %lu x %lu\r\n", w.rows, w.cols);
    	w.print();
    	printf("Bias matrix: %lu x%lu\r\n", b.rows, b.cols);
    	b.print();
    }

    void UpdateWeights(f32 lr, uint32_t batchsize = 1)
    {
        // scale the learning rate by the batch size. By default, the batch size is set to 1.
        lr = lr * (1.0f / (f32)batchsize);

        // // MOMENTUM
        f32 momentum = MOMENTUM;
        vdw = (vdw * momentum) + (dw * 0.1f);
        vdb = (vdb * momentum) + (db * 0.1f);

        for (uint32_t i = 0; i < w.rows; ++i)
        {
            for (uint32_t j = 0; j < w.cols; ++j)
            {
                // Update weights
                w.data[i * w.cols + j] -= lr * this->vdw[i * this->vdw.cols + j];
            }
            // Update bias
            b.data[i] -= lr * this->vdb.data[i];
        }
    }

    void UpdateWeights(M grads, M a, f32 lr)
    {
        // MOMENTUM
        vdw = vdw * 0.9f + dw * (1.0f-0.9f);
        vdb = vdb * 0.9f + db * (1.0f-0.9f);

        for (uint32_t i = 0; i < w.rows; ++i)
        {
            uint32_t index = i * w.cols;
            for (uint32_t j = 0; j < w.cols; ++j)
            {
                dw.data[index + j] = grads.data[j] * a.data[i];
                // update momentum vel
                vdw.data[index + j] = vdw.data[index + j] * 0.9f + dw.data[index + j] * (1.0f-0.9f);
                // Update weights
                w.data[index + j] -= lr * this->vdw.data[index + j];
            }
            db.data[i] = grads.data[i];
            // update momentum vel
            vdb.data[i] = vdb.data[i] * 0.9f + db.data[i] * (1.0f-0.9f);
            // Update bias
            b.data[i] -= lr * this->vdb.data[i];
        }
    }
};

struct Size3D{
	uint32_t h;
	uint32_t w;
	uint32_t c;
};

Size3D get_output_from_kernel(uint32_t ih, uint32_t iw, uint32_t kh, uint32_t kw, uint32_t kc){
    Size3D output;
    output.c = kc;
    output.h = ih - kh + 1;
    output.w = iw - kw + 1;
    return output;
}



class DenseNetwork {
public:
	/**
	 * will store the layers and initialize them with random values
	 * nbLayers: how many layers to make in the network
	 * layerSizes: list of the size for each layer.
	 * Ex: sine model with 3 layers, input is 1 value, then connected to 16x16, then reduced to 1
	 */
	DenseNetwork(uint8_t nbLayers, uint32_t* layerSizes)
		: m_nbLayers(nbLayers), m_layerSize(layerSizes)
	{
		layerAddr = (Layer**) PushSize(&MemoryArena, m_nbLayers*sizeof(Layer*));
		printf("\r\nCreate dense network with %d layers\r\n", m_nbLayers);
		for(int i=0;i<nbLayers;i++){
			printf("Initialize a layer of size %lu->%lu\r\n",m_layerSize[i],m_layerSize[i+1]);
			layerAddr[i] = Layer::create(m_layerSize[i], m_layerSize[i+1]);
		}
	}


	M predict(M input){
		M tmpVal = input;
		for(int i=0;i<m_nbLayers;i++){
			tmpVal = Relu(layerAddr[i]->forward(tmpVal));
		}

	    return tmpVal;
	}

private:
	uint8_t m_nbLayers;
	uint32_t* m_layerSize;
	Layer** layerAddr;
};

#endif /* INC_NN_HPP_ */
