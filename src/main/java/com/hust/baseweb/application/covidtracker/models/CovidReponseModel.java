package com.hust.baseweb.application.covidtracker.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.domain.Page;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CovidReponseModel {
    private int totalCases;
    private int totalDeaths;
    private int totalRecovers;
    private int totalDiffFromPrevDay;
}
