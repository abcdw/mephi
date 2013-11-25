package multiply;

public class multiplier {

    public static int multiply(int a, int b) {
        if (b < 0)
            return multiply(-a, -b);

        int originalA = a;
        int shiftedA = originalA;
        int answer = 0;

        while (b > 0)
            if (b % 2 != 0) {
                answer += shiftedA;
                --b;
            } else {
                while (b % 2 == 0) {
                    b >>= 1;
                    shiftedA <<= 1;
                }
            }

        return answer;
    }

    public static void main(String[] args) {
        System.out.println(multiply(-5, -13));
    }
}
