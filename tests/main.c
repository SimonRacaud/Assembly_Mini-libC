/*
** EPITECH PROJECT, 2021
** tests
** File description:
** main.c, Thursday, 1st January 1970 1:00:00 am simon.racaud@epitech.eu
*/

#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

size_t (*_strlen)(const char *str);

void tests_strlen(void)
{
    printf("strlen('hello world') = %lu : 11 \n", _strlen("Hello World"));
    printf("strlen('hello world') = %lu : 12 \n", _strlen("Hello World2"));
    printf("strlen('hello world') = %lu : 0 \n", _strlen(""));
    printf("strlen('hello world') = %lu : 1 \n", _strlen("a"));
    printf("\n");
}

int main(void)
{
    void *lib = dlopen("./libasm.so", RTLD_LAZY);
    if (!lib)
        return 1;
    *(void **) (&_strlen) = dlsym(lib, "strlen");

    if (!_strlen)
        return 2;

    tests_strlen();

    dlclose(lib);
    return 0;
}