
#define normal_work_rate 10
#include <stdio.h>

int main() {
	double hours = 0, tax = 0, salary = 0;
	const int overtime_rate = 15;
	const double taxFor300 = 0.13;
    const double taxFor450 = 0.15;
	scanf("%lf", &hours);

	if (hours > 40){
		salary = (hours - 40)* overtime_rate + 400;
	} else {
		salary = hours * normal_work_rate;
	}


	if (salary < 300) {
		tax = salary * taxFor300;
	} else if (salary < 450) {
		tax = 300 * taxFor300 + (salary - 300)* taxFor450;
	} else {
		tax = 300 * taxFor300 + 150 * taxFor450 + (salary - 450) * 0.2;
	}

	printf("Налог: %lf\nЗп без налога: %lf\n", tax, salary-tax);

	return 0;
}
