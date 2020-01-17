package arch.sm213.machine.student;

import machine.AbstractMainMemory;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;

public class MainMemoryTest {
    private MainMemory mainMemory;
    private byte b1;
    private byte b2;
    private byte b3;
    private byte b4;

    @BeforeEach
    void runBefore() {
        mainMemory = new MainMemory(8);
        b1 = (byte) 0x11;
        b2 = (byte) 0x22;
        b3 = (byte) 0x33;
        b4 = (byte) 0x44;
    }

    //Test setting a negative address
    @Test
    public void testSetExceptionNegative() {
        try {
            mainMemory.set(-1,new byte[2]);
            fail();
        } catch (AbstractMainMemory.InvalidAddressException e) {
            System.out.println("pass");
        }
    }

    //Test setting an address outside the bound of the byte array
    @Test
    public void testSetExceptionHigh() {
        try {
            mainMemory.set(0, new byte[16]);
            fail();
        } catch (AbstractMainMemory.InvalidAddressException e) {
            System.out.println("pass");
        }
    }

    //Test storing a byte array smaller than array being copied into
    @Test
    public void testSetLowBound() {
        byte[] bytes = new byte[2];
        try {
            mainMemory.set(0,bytes);
            for (int i = 0; i < mainMemory.length(); i++) {
                if (mainMemory.get(i,1) == null) {
                    assertEquals(1,i);
                }
            }
        } catch (AbstractMainMemory.InvalidAddressException e) {
            fail();
        }
    }

    //Test storing a byte array the same size as the array being copied into
    @Test
    public void testSetHighBound() {
        byte[] bytes = new byte[8];
        try {
            mainMemory.set(0,bytes);
            assertEquals(8,mainMemory.length());
        } catch (AbstractMainMemory.InvalidAddressException e) {
            fail();
        }
    }

    //Test getting a byte outside the bound in the negative sense
    @Test
    public void testGetExceptionNegative() {
        try {
            mainMemory.get(-1,2);
            fail();
        } catch (AbstractMainMemory.InvalidAddressException e) {
            System.out.println("pass");
        }
    }

    //Test getting a byte outside the bound in the positive sense
    @Test
    public void testGetExceptionHigh() {
        try {
            mainMemory.get(2,8);
            fail();
        } catch (AbstractMainMemory.InvalidAddressException e) {
            System.out.println("pass");
        }
    }

    @Test
    public void testGetWhole() {
        try {
            assertEquals(8,mainMemory.get(0,8).length);
        } catch (AbstractMainMemory.InvalidAddressException e) {
            fail();
        }
    }

    //Test get
    @Test
    public void testGetPart() {
        try {
            assertEquals(4,mainMemory.get(2,4).length);
        } catch (AbstractMainMemory.InvalidAddressException e) {
            fail();
        }
    }

    //Test if accessAligned function is working
    @Test
    public void TestIsAccessAligned() {
        assertTrue(mainMemory.isAccessAligned(8,2));
        assertFalse(mainMemory.isAccessAligned(8,3));
    }

    //Test bytes to int
    @Test
    public void bytesToInteger() {
        assertEquals(287454020, mainMemory.bytesToInteger(b1, b2, b3, b4));
    }

    //Test int to byte
    @Test
    public void integerToBytes() {
        byte[] bytes = mainMemory.integerToBytes(1234567);
        assertEquals(-121, bytes[3]);
        assertEquals(-42,bytes[2]);
        assertEquals(18,bytes[1]);
        assertEquals(0,bytes[0]);
    }

    //Test int to bytes with 0
    @Test
    public void integerToBytesZero() {
        byte[] bytes = mainMemory.integerToBytes(0);
        assertEquals(0, bytes[3]);
        assertEquals(0,bytes[2]);
        assertEquals(0,bytes[1]);
        assertEquals(0,bytes[0]);
    }

    //Test largest possible int
    @Test
    public void integerToBytesLargest() {
        byte[] bytes = mainMemory.integerToBytes(2147483647);
        assertEquals(-1, bytes[3]);
        assertEquals(-1,bytes[2]);
        assertEquals(-1,bytes[1]);
        assertEquals(127,bytes[0]);
    }

    //Test smallest possible int
    @Test
    public void integerToBytesSmallest() {
        byte[] bytes = mainMemory.integerToBytes(-2147483648);
        assertEquals(0, bytes[3]);
        assertEquals(0,bytes[2]);
        assertEquals(0,bytes[1]);
        assertEquals(-128,bytes[0]);
    }
}
