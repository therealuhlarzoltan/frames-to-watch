import hu.therealuhlarzoltan.framestowatch.util.exception.InvalidInputException;

public class InvalidInputExceptionTest {

    void invalidInputDataException_instantiatedWithMessage_instanceCreated() {
        InvalidInputException testedObject = new InvalidInputException("invalid input data");
    }

}
