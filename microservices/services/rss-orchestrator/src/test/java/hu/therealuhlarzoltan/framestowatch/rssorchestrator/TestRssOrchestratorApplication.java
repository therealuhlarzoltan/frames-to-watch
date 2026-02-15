package hu.therealuhlarzoltan.framestowatch.rssorchestrator;

import org.springframework.boot.SpringApplication;

public class TestRssOrchestratorApplication {

    public static void main(String[] args) {
        SpringApplication.from(RssOrchestratorApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}
