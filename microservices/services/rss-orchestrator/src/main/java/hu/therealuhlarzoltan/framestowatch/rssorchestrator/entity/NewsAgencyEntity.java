package hu.therealuhlarzoltan.framestowatch.rssorchestrator.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "news_agencies")
@Data
@EqualsAndHashCode
public class NewsAgencyEntity {
    private String name;
}
