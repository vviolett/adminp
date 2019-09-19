package ch3;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class TasksTest {
    @Test
    public void getSum() throws Exception {
        List<Integer> list = new ArrayList<>(Arrays.asList(3, 4, 5, 7, 9));
        Tasks task = new Tasks();
        assertEquals(28, task.getSum(list));
    }

    @Test
    public void getClosectNumPosition() throws Exception {
        List<Integer> list = new ArrayList<>(Arrays.asList(3, 4, 5, 7, 9));
        Tasks task = new Tasks();
        assertEquals(4, task.getClosectNumPosition(list, 11));
        assertEquals(0, task.getClosectNumPosition(list, 2));
    }

    @Test
    public void getPairNumPosition() throws Exception {
        List<Integer> listA = new ArrayList<>(Arrays.asList(-1, 3, 8, 2, 9, 5));
        List<Integer> listB = new ArrayList<>(Arrays.asList(4, 1, 2, 10, 5, 20));
        Tasks task = new Tasks();
        assertEquals(Arrays.asList(3, 20), task.getPairNumPosition(listA, listB, 24));
    }

}
