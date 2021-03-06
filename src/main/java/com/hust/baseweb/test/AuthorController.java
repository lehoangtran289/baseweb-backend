package com.hust.baseweb.test;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class AuthorController {
    private AuthorService authorService;
    private AuthorRepo authorRepo;

    @GetMapping(path = "/findAuthors")
    public ResponseEntity<?> findAuthorsWithFilter(Pageable pageable,
                                                   @RequestParam(required = false) String search) {
        return ResponseEntity.ok().body(authorService.findAllWithFilter(search, pageable));
    }

}
