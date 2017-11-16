#include <stdio.h>

int	ft_strlen(char*str);

int	main(int argc, char **argv)
{
	if (argc > 1)
		printf("%i", ft_strlen(argv[1]));
	return (0);
}
