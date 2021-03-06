package com.hust.baseweb.rest.user;

import com.hust.baseweb.entity.PartyType;
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
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.UUID;

@RepositoryRestResource(path = "DPersons", excerptProjection = UserRestBriefProjection.class)
public interface UserRestRepository extends JpaRepository<DPerson, UUID>, QuerydslPredicateExecutor<DPerson>,
        QuerydslBinderCustomizer<QDPerson> {

    Page<DPerson> findByPartyType(PartyType partyType, Pageable pageable);

    @Query("select p from DPerson p")
    Page<UserRestBriefProjection> findAllDPerson(Pageable page);

    @Query("select p from DPerson p where p.partyType.partyTypeId = :type and p.status.id = :status and lower" +
            "(COALESCE(concat(trim(p.person.firstName), trim(p.person.middleName), trim(p.person.lastName)), " +
            "'')) like lower(CONCAT('%',:fullNameString,'%')) ")
    Page<UserRestBriefProjection> findByPartyTypeAndStatusAndFullNameLike(Pageable page, String type,
                                                                          String status, String fullNameString);

    @Override
    default void customize(QuerydslBindings bindings, QDPerson root) {
        bindings
                .bind(String.class)
                .first((SingleValueBinding<StringPath, String>) StringExpression::containsIgnoreCase);
    }
}
