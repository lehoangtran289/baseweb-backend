package com.hust.baseweb.test;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Author {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long authorId;

    @NotNull
    private String authorName;

    @ManyToMany(mappedBy = "authors")
    private List<Book> books;

    public Author(String authorName) {
        this.authorName = authorName;
    }
}
