##
## EPITECH PROJECT, 2021
## Project_2021
## File description:
## Project makefile
##

AS = nasm
cc = ld

SRC_DIR   = ./src/
SRC_FILES =	strlen.asm		\
			lib.asm			\
			strchr.asm		\
			memset.asm		\
			memcpy.asm		\

SRC 	= $(addprefix $(SRC_DIR), $(SRC_FILES))

NAME=libasm.so
TEST_NAME=test.out

CFLAGS = -fPIC -shared
ASFLAGS=-f elf64
LDFLAGS=
#LIBFLAGS=-shared

OBJ=$(SRC:.asm=.o)

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@

test: $(NAME)
	gcc -W -Wall -Wextra tests/main.c -g -o $(TEST_NAME) -ldl

tests_run: test
	LD_PRELOAD=./libasm.so ./$(TEST_NAME)
	rm -f $(TEST_NAME)

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f $(OBJ)
	rm -f tests/*.o

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: clean fclean re
