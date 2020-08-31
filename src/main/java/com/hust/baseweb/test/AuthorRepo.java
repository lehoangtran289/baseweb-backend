package com.hust.baseweb.test;

import com.querydsl.core.types.dsl.StringExpression;
import com.querydsl.core.types.dsl.StringPath;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.querydsl.binding.QuerydslBinderCustomizer;
import org.springframework.data.querydsl.binding.QuerydslBindings;
import org.springframework.data.querydsl.binding.SingleValueBinding;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.core.annotation.RestResource;

import java.util.Optional;

@RepositoryRestResource(exported = true, path = "authors")
public interface AuthorRepo extends JpaRepository<Author, Long>, QuerydslPredicateExecutor<Author>,
        QuerydslBinderCustomizer<QAuthor> {

    Optional<Author> findById(Long authorId);

    @RestResource(path = "nameStartsWith")
    Optional<Author> findByAuthorNameStartsWith(String authorName);

    @RestResource(path = "findByBookId")
    @Query("select a from Author a join a.books b where b.bookId = ?1")
    Page<Author> findByBookId(Long bookId, Pageable pageable);

    @Override
    default void customize(final QuerydslBindings bindings, final QAuthor root) {
        bindings
                .bind(String.class)
                .first((SingleValueBinding<StringPath, String>) StringExpression::containsIgnoreCase);
    }
}
