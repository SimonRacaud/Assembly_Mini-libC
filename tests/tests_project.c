/*
** EPITECH PROJECT, 2021
** Unit_Test_Criterion
** File description:
** Test File
*/

#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <criterion/criterion.h>
#include <criterion/redirect.h>

size_t (*_strlen)(const char *str);
char *(*_strchr)(const char *, int c);
void *(*_memset)(void *, int c, size_t n);
void *(*_memcpy)(void *, void *, size_t n);
int (*_strcmp)(char *, char *);
void *(*_memmove)(void *, void *, size_t);
int (*_strncmp)(char *, char *, size_t);
int (*_strcasecmp)(char *, char *);
char *(*_rindex)(char *, int);
char *(*_strstr)(char *, char *);
char *(*_strpbrk)(char *, char *);

void *lib = NULL;

void setup(void)
{
    if (lib)
        return;
    lib = dlopen("./libasm.so", RTLD_LAZY);
    if (!lib)
        return;
    *(size_t **) (&_strlen) = dlsym(lib, "strlen");
    *(char **) (&_strchr) = dlsym(lib, "strchr");
    *(void **) (&_memset) = dlsym(lib, "memset");
    *(void **) (&_memcpy) = dlsym(lib, "memcpy");
    *(int **) (&_strcmp) = dlsym(lib, "strcmp");
    *(void **) (&_memmove) = dlsym(lib, "memmove");
    *(int **) (&_strncmp) = dlsym(lib, "strncmp");
}

void teardown(void)
{
    // dlclose(lib);
}

Test(strlen, t01, .init = setup, .fini = teardown)
{
    cr_assert_eq(_strlen("Hello world"), strlen("Hello world"));
    cr_assert_eq(_strlen("Hello world2"), strlen("Hello world2"));
    cr_assert_eq(_strlen(""), strlen(""));
    cr_assert_eq(_strlen("a"), strlen("a"));
}

Test(strchr, t01, .init = setup, .fini = teardown)
{
    cr_assert_str_eq(_strchr("hello world", 'w'), strchr("hello world", 'w'));
    cr_assert_eq(_strchr("hello world", 'x'), strchr("hello world", 'x'));
    cr_assert_str_eq(
        _strchr("hello world", '\0'), strchr("hello world", '\0'));
    cr_assert_str_eq(_strchr("hello world", 'd'), strchr("hello world", 'd'));
    cr_assert_str_eq(_strchr("hello world", 'h'), strchr("hello world", 'h'));
    cr_assert_eq(_strchr("", 'h'), strchr("", 'h'));
}

Test(memset, t01, .init = setup, .fini = teardown)
{
    char buf[1024] = {0};
    char buf2[1024] = {0};

    cr_assert_str_eq(_memset(buf, 'x', 3), memset(buf2, 'x', 3));
    cr_assert_str_eq(_memset(buf, 'l', 10), memset(buf2, 'l', 10));
    cr_assert_str_eq(_memset(buf, 'z', 0), buf2);
    cr_assert_str_eq(_memset(buf, 'y', 5), memset(buf2, 'y', 5));
}

Test(memcpy, t01, .init = setup, .fini = teardown)
{
    char buf[1024] = {0};
    char buf2[1024] = {0};

    cr_assert_str_eq(_memcpy(buf, (void *) "hello world", 3),
        memcpy(buf2, (void *) "hello world", 3));
    cr_assert_str_eq(
        _memcpy(buf, "hello world", 0), memcpy(buf2, "hello world", 0));
    cr_assert_str_eq(_memcpy(buf, "O", 1), memcpy(buf2, "O", 1));
}

Test(strcmp, t01, .init = setup, .fini = teardown)
{
    cr_assert_eq(_strcmp("aa", "aa"), strcmp("aa", "aa"));
    cr_assert_eq(_strcmp("aa", "ab"), strcmp("aa", "ab"));
    cr_assert_eq(_strcmp("", ""), strcmp("", ""));
    cr_assert_eq(_strcmp("ab", "abc"), strcmp("ab", "abc"));
    cr_assert_eq(_strcmp("abc", "ab"), strcmp("abc", "ab"));
}

Test(memmove, t01, .init = setup, .fini = teardown)
{
    char buf[1024] = "abcdefg_";
    char buf2[1024] = "abcdefg_";

    cr_assert_str_eq(_memmove(buf + 1, buf, 7), memmove(buf2 + 1, buf2, 7));
}

Test(memmove, t02, .init = setup, .fini = teardown)
{
    char buf[1024] = "abcdefg_";
    char buf2[1024] = "abcdefg_";

    cr_assert_str_eq(_memmove(buf, buf + 1, 7), memmove(buf2, buf2 + 1, 7));
}

Test(memmove, t03, .init = setup, .fini = teardown)
{
    char buf[1024] = "abcdefg_";
    char buf2[1024] = "abcdefg_";

    cr_assert_str_eq(_memmove(buf, buf, 7), memmove(buf2, buf2, 7));
}

Test(strncmp, t01, .init = setup, .fini = teardown)
{
    cr_assert_eq(_strncmp("", "", 8), strncmp("", "", 8));
    cr_assert_eq(_strncmp("a", "a", 1), strncmp("a", "a", 1));
    cr_assert_eq(_strncmp("a", "b", 1), strncmp("a", "b", 1));
    cr_assert_eq(_strncmp("ac", "a", 3) > 0, strncmp("ac", "a", 3) > 0);
    cr_assert_eq(_strncmp("ac", "acd", 2), strncmp("ac", "acd", 2));
}

Test(strcasecmp, t01, .init = setup, .fini = teardown)
{
    *(int **) (&_strcasecmp) = dlsym(lib, "strcasecmp");
    cr_assert_eq(_strcasecmp("Aa", "aa"), strcasecmp("Aa", "aa"));
    cr_assert_eq(_strcasecmp("aa", "aA"), strcasecmp("aa", "aA"));
    cr_assert_eq(_strcasecmp("", ""), strcasecmp("", ""));
    cr_assert_eq(_strcasecmp("aB", "abc") < 0, strcasecmp("aB", "abc") < 0);
    cr_assert_eq(_strcasecmp("abC", "ab") < 0, strcasecmp("abC", "ab") < 0);
}

Test(rindex, t01, .init = setup, .fini = teardown)
{
    *(char ***) (&_rindex) = dlsym(lib, "rindex");
    cr_expect_eq(_rindex("abcde", 'a'), rindex("abcde", 'a'));
    cr_expect_eq(_rindex("abcde", 'e'), rindex("abcde", 'e'));
    cr_assert_eq(_rindex("abcde", 'c'), rindex("abcde", 'c'));
    cr_assert_eq(_rindex("abcde", 'x'), rindex("abcde", 'x'));
    cr_assert_eq(_rindex("abcde", '\0'), rindex("abcde", '\0'));
    cr_assert_eq(_rindex("", 'x'), rindex("", 'x'));
    cr_assert_eq(_rindex("", '\0'), rindex("", '\0'));
}

Test(strstr, t01, .init = setup, .fini = teardown)
{
    *(char **) (&_strstr) = dlsym(lib, "strstr");
    cr_expect_str_eq(_strstr("cc", "cc"), strstr("cc", "cc"));
    cr_expect_str_eq(_strstr("acc", "cc"), strstr("acc", "cc"));
    cr_expect_str_eq(_strstr("abccde", "cc"), strstr("abccde", "cc"));
    cr_expect_eq(_strstr("abcde", "cc"), strstr("abcde", "cc"));
    cr_expect_eq(_strstr("", "cc"), strstr("", "cc"));
    cr_expect_str_eq(_strstr("abccde", "c"), strstr("abccde", "c"));
}

Test(strpbrk, t01, .init = setup, .fini = teardown)
{
    *(char **) (&_strpbrk) = dlsym(lib, "strpbrk");
    cr_expect_str_eq(_strpbrk("efgc", "abc"), strpbrk("efgc", "abc"));
    cr_expect_str_eq(_strpbrk("efgc", "pfg"), strpbrk("efgc", "pfg"));
    cr_expect_str_eq(_strpbrk("eagc", "a"), strpbrk("eagc", "a"));
    cr_expect_eq(_strpbrk("", "a"), strpbrk("", "a"));
    cr_expect_eq(_strpbrk("", ""), strpbrk("", ""));
    cr_expect_eq(_strpbrk("eagc", "zui"), strpbrk("eagc", "zui"));
}