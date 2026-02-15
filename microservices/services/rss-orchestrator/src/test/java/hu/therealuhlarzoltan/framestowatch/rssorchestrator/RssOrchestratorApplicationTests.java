package hu.therealuhlarzoltan.framestowatch.rssorchestrator;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;

@Import(TestcontainersConfiguration.class)
@SpringBootTest
class RssOrchestratorApplicationTests {

    @Test
    void run_springApplication_contextLoads() {
    }

}
