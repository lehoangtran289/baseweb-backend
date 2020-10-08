package com.hust.baseweb.application.covidtracker.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CovidReponseModel {
    private List<LocationStat> dataList;
    private int totalCases;
    private int totalDeaths;
    private int totalRecovers;
    private int totalDiffFromPrevDay;
    private Date date;
}
