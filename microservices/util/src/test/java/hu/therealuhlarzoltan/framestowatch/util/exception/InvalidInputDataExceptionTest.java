package hu.therealuhlarzoltan.framestowatch.util.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class InvalidInputDataExceptionTest {

    private static final String EXCEPTION_MESSAGE = "invalid input data";
    private static final Throwable EXCEPTION_CAUSE = new RuntimeException();

    @Test
    void invalidInputDataException_throwWithoutProperties_exceptionThrown() {
        InvalidInputDataException exception = assertThrows(
                InvalidInputDataException.class,
                () -> { throw new InvalidInputDataException(); }
        );

        assertInstanceOf(InvalidInputDataException.class, exception, "Exception should be instance of InvalidInputDataException.class");
    }

    @Test
    void invalidInputDataException_throwWithMessage_exceptionThrownWithMessage() {
        InvalidInputDataException exception = assertThrows(
                InvalidInputDataException.class,
                () -> { throw new InvalidInputDataException(EXCEPTION_MESSAGE); }
        );

        assertEquals(EXCEPTION_MESSAGE, exception.getMessage(), "Exception message should match the declared message");
    }

    @Test
    void invalidInputDataException_throwWithMessageAndCause_exceptionThrownWithMessageAndCause() {
        InvalidInputDataException exception = assertThrows(
                InvalidInputDataException.class,
                () -> { throw new InvalidInputDataException(EXCEPTION_MESSAGE, EXCEPTION_CAUSE); }
        );

        assertInstanceOf(InvalidInputDataException.class, exception, "Exception should be instance of InvalidInputDataException.class");
        assertEquals(EXCEPTION_MESSAGE, exception.getMessage(), "Exception message should match the declared message");
        assertSame(EXCEPTION_CAUSE, exception.getCause(), "Exception cause should be the same as the declared instance");
    }

    @Test
    void invalidInputDataException_throwWithCause_exceptionThrownWithCause() {
        InvalidInputDataException exception = assertThrows(
                InvalidInputDataException.class,
                () -> { throw new InvalidInputDataException(EXCEPTION_CAUSE); }
        );

        assertInstanceOf(InvalidInputDataException.class, exception, "Exception should be instance of InvalidInputDataException.class");
        assertSame(EXCEPTION_CAUSE, exception.getCause(), "Exception cause should be the same as the declared instance");
    }

    @Test
    void invalidInputDataException_throwWithAllProperties_exceptionThrownWithMatchingProperties() {
        InvalidInputDataException exception = assertThrows(
                InvalidInputDataException.class,
                () -> { throw new InvalidInputDataException(EXCEPTION_MESSAGE, EXCEPTION_CAUSE, true, true); }
        );

        assertInstanceOf(InvalidInputDataException.class, exception, "Exception should be instance of InvalidInputDataException.class");
        assertEquals(EXCEPTION_MESSAGE, exception.getMessage(), "Exception message should match the declared message");
        assertSame(EXCEPTION_CAUSE, exception.getCause(), "Exception cause should be the same as the declared instance");
    }


}
