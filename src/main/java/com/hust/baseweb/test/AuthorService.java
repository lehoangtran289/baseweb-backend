package com.hust.baseweb.test;

import com.querydsl.core.types.dsl.BooleanExpression;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class AuthorService {
    private AuthorRepo authorRepo;

    public Page<Author> findAllWithFilter(String searchString, Pageable pageable) {
        AuthorPredicateBuilder builder = new AuthorPredicateBuilder();

        if (searchString != null) {
            Pattern pattern = Pattern.compile("(\\w+?)(:|<|>)(\\w+?),");
            Matcher matcher = pattern.matcher(searchString + ",");
            while (matcher.find()) {
                builder.with(matcher.group(1), matcher.group(2), matcher.group(3));
                System.out.println(matcher.group(1) + " " + matcher.group(2) + " " + matcher.group(3));
            }
            BooleanExpression exp = builder.build();
            System.out.println(exp);
            return authorRepo.findAll(exp, pageable);
        }
        return authorRepo.findAll(pageable);
    }

}
