package hu.therealuhlarzoltan.framestowatch.rssorchestrator;

import org.springframework.boot.SpringApplication;

@SuppressWarnings("PMD.MethodArgumentCouldBeFinal")
public final class TestRssOrchestratorApplication {

    private TestRssOrchestratorApplication() {
        // Avoiding instantiation
    }

    public static void main(String[] args) {
        SpringApplication.from(RssOrchestratorApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}
