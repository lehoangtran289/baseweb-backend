package com.hust.baseweb.application.covidtracker.models;

import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CovidReponseModel {
    private int totalCases;
    private int totalDeaths;
    private int totalRecovers;
    private int totalDiffFromPrevDay;
    private LocalDate date;
}
