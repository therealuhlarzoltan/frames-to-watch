import hu.therealuhlarzoltan.framestowatch.util.exception.InvalidInputDataException;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class InvalidInputDataExceptionTest {

    @Test
    void invalidInputDataException_throwWithMessage_exceptionThrown() {
        InvalidInputDataException exception = assertThrows(
                InvalidInputDataException.class,
                () -> { throw new InvalidInputDataException("invalid input data"); }
        );

        assertEquals("invalid input data", exception.getMessage(), "Exception message should match the declared message");
    }
}
