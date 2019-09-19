package ch3;
import java.util.*;
public class Tasks {

    public static void main(String[] args) {
        List<Integer> list = new ArrayList<>(Arrays.asList(3, 4, 5, 7, 9));
        getSum(list);
        getClosectNumPosition(list, 9);
        List<Integer> listA = new ArrayList<>(Arrays.asList(-1, 3, 8, 2, 9, 5));
        List<Integer> listB = new ArrayList<>(Arrays.asList(4, 1, 2, 10, 5, 20));
        getPairNumPosition(listA, listB, 24);
    }

    /*
    Write a Java program to sum values of a list.
     */
    public static int getSum(List<Integer> list){
        return list.stream().reduce(0, (acc, elem) -> acc + elem);
    }

    /*
    Write a java program to find in a list the position where
    the number closest to a given value is located
     */
    public static int getClosectNumPosition(List<Integer> list, Integer num){
        int min = Math.abs(list.get(0) - num);
        int k = 0;
        for (int i = 1; i < list.size(); i++) {
            int diff = Math.abs(list.get(i) - num);
            if (diff < min) {
                min = diff;
                k = i;
            }
        }
        return k;
    }

    /*
    Given two lists: [-1, 3, 8, 2, 9, 5] and [4, 1, 2, 10, 5, 20 ] and a target number 24,
    write a function that finds a pair of numbers (one in each list) which the sum is the
    closest to the target number.
     */
    public static List<Integer> getPairNumPosition(List<Integer> listA, List<Integer> listB, Integer num){
        List<Integer> res = new ArrayList<>(Collections.nCopies(2, null));
        int diff = Integer.MAX_VALUE;
        for (int i = 0; i < listA.size(); i++) {
            for (int j = 0; j < listB.size(); j++) {
                if (Math.abs(listA.get(i) + listB.get(j) - num) < diff) {
                    diff = Math.abs(listA.get(i) + listB.get(j) - num);
                    res.set(0, listA.get(i));
                    res.set(1, listB.get(j));
                }
            }
        }
        return res;
    }
}
