#include <iostream>

extern "C" void arr_min_max(int[], int, int *, int *);

int main() {
	int arr[] = {123, 42, 678, 145, 999, 100, 1234};
	int length = 7;
	int max;
	int min;
	arr_min_max(arr, length, &min, &max);
	std::cout << "The minimum value in the array is " << min << ".\n";
	std::cout << "The maximum value in the array is " << max << ".\n";
	return 0;
}
	

