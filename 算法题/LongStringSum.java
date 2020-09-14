import java.util.Scanner;

/**
 * 面试遇到的算法题
 * 2.两个超长数字字符串求和
 */
public class LongStringSum {
    

public static String addLongString(String addend, String augend) {
        StringBuilder res = new StringBuilder();
        // 进位信息
        int carry = 0;
        
        int i = addend.length() - 1;
        int j = augend.length() - 1;
        while (i >= 0 || j >= 0 || carry != 0) {
            int sum = carry;
            if (i >= 0) {
                //char类型转int
                sum += addend.charAt(i--) - '0';
            }
            if (j >= 0) {
                sum += augend.charAt(j--) - '0';
            }
            res.append(sum % 10);
            carry = sum / 10;
        }
        return res.reverse().toString();
    }
 
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        while (in.hasNext()) {
            String addend = in.next();
            String augend = in.next();
            String res = addLongString(addend, augend);
            System.out.println(res);
        }
    }
}
