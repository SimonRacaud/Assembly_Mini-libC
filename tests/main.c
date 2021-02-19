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
char *(*_strchr)(const char *, int c);
void *(*_memset)(void *, int c, size_t n);
void *(*_memcpy)(void *, void *, size_t n);

void tests_strlen(void)
{
    printf("strlen('hello world') = %lu : 11 \n", _strlen("Hello World"));
    printf("strlen('hello world') = %lu : 12 \n", _strlen("Hello World2"));
    printf("strlen('hello world') = %lu : 0 \n", _strlen(""));
    printf("strlen('hello world') = %lu : 1 \n", _strlen("a"));
    printf("\n");
}

void tests_strchr(void)
{
    printf("strchr('hello world', w) = %c \n", *_strchr("hello world", 'w'));
    printf(
        "strchr('hello world', x) = %p / nil \n", _strchr("hello world", 'x'));
    printf(
        "strchr('hello world', 0) = %d / 0 \n", *_strchr("hello world", '\0'));
    printf("strchr('hello world', d) = %c \n", *_strchr("hello world", 'd'));
    printf("\n");
}

void tests_memset(void)
{
    char buf[1024] = {0};

    printf("memset('xxx') = %s \n", (char *) _memset((void *) buf, 'x', 3));
    printf("memset('llllllllll') = %s \n",
        (char *) _memset((void *) buf, 'l', 10));
    printf("memset('llllllllll') = %s \n",
        (char *) _memset((void *) buf, 'x', 0));
    printf("\n");
}

void tests_memcpy(void)
{
    char buf[1024] = {0};

    printf("memcpy('xxx') = %s \n", (char *) _memcpy(buf, "xxxzp", 3));
    printf("memcpy('xxx') = %s \n", (char *) _memcpy(buf, "", 0));
    printf("memcpy('Oxx') = %s \n", (char *) _memcpy(buf, "O", 1));
}

int main(void)
{
    void *lib = dlopen("./libasm.so", RTLD_LAZY);

    if (!lib)
        return 1;
    *(size_t **) (&_strlen) = dlsym(lib, "strlen");
    *(char **) (&_strchr) = dlsym(lib, "strchr");
    *(void **) (&_memset) = dlsym(lib, "memset");
    *(void **) (&_memcpy) = dlsym(lib, "memcpy");

    // tests_strlen();
    // tests_strchr();
    // tests_memset();
    // tests_memcpy();

    return 0;
}