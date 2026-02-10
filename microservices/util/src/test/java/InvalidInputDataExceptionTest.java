import hu.therealuhlarzoltan.framestowatch.util.exception.InvalidInputDataException;

public class InvalidInputDataExceptionTest {

    void invalidInputDataException_instantiatedWithMessage_instanceCreated() {
        InvalidInputDataException testedObject = new InvalidInputDataException("invalid input data");
    }

}
