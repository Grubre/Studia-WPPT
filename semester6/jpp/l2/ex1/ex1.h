#pragma once

typedef struct {
    int x, y, d;
} ExtendedGcd;

int factorial(int n);
int gcd(int a, int b);
ExtendedGcd extendedGcd(int a, int b);
