/**
 * 3.将给定的字符串，按照规格压缩，输出压缩后的字符串
 * 压缩规则：
 *         相同字符串连续，则压缩为字符+数字个数，如‘aaaa’，压缩为‘a4’
 * 
 */

public class CompressString {

    public static void main(String[] args) {

        System.out.println(compressStr("sfgdgfdgggggasssdfsdfsdffh"));
        
    }

    public static String compressStr(String str){
        StringBuilder sb = new StringBuilder();
        // 连接字符串的个数
        int sum = 1;
        // 获取第一个字符
        char c1 = str.charAt(0);
        for(int i=1;i<str.length();i++){
            char c2 = str.charAt(i);
            // 把前一个字符串和当前字符串比较
            if(c1==c2){
                // 个数相同就+1
                sum++;
                continue;
            }
            if(sum>1){
                sb.append(c1).append(sum);
            }else{
                sb.append(c1);
            }
            //字符往后替换，数量置1
            c1=c2;
            sum=1;
        }
        // 加上最后一个字符及其个数
        if(sum>1){
            sb.append(c1).append(sum);
        }else{
            sb.append(c1);
        }
        return sb.toString();
    }
    
}
