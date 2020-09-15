package com.hust.baseweb.test;

import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.StringExpression;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.querydsl.binding.QuerydslBinderCustomizer;
import org.springframework.data.querydsl.binding.QuerydslBindings;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.core.annotation.RestResource;

import java.util.Optional;

@RepositoryRestResource(exported = true, path = "authors")
public interface AuthorRepo extends JpaRepository<Author, Long>, QuerydslPredicateExecutor<Author>,
        QuerydslBinderCustomizer<QAuthor> {

    Optional<Author> findById(Long authorId);

    // customized querydsl
    Page<Author> findAll(Predicate predicate, Pageable pageable);

    // http://127.0.0.1:8080/api/authors/search/nameStartsWith{?authorName}
    @RestResource(path = "nameStartsWith")
    Optional<Author> findByAuthorNameStartsWith(String authorName);

    @RestResource(path = "findByBookId")
    @Query("select a from Author a join a.books b where b.bookId = ?1")
    Page<Author> findByBookId(Long bookId, Pageable pageable);

    // http://127.0.0.1:8080/api/authors?authorName=or&authorId=1
    // klq den customized querydsl
    @Override
    default void customize(final QuerydslBindings bindings, final QAuthor root) {
        // AND
        bindings.bind(root.authorName).first(StringExpression::containsIgnoreCase);

        bindings.bind(root.authorId).first((path, value) -> path.eq(value));

        // OR
        // https://stackoverflow.com/questions/55723080/querydsl-predicate-bindings-or-between-multiple-path

    }
}
