package com.hust.baseweb.application.covidtracker.controllers;

import com.hust.baseweb.application.covidtracker.models.CovidReponseModel;
import com.hust.baseweb.application.covidtracker.models.LocationStat;
import com.hust.baseweb.application.covidtracker.services.CovidDataService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

@RestController
@Log4j2
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class CovidReportController {

    private CovidDataService service;

    @GetMapping("/covid-data")
    public ResponseEntity<?> getCovidData() {
        List<LocationStat> dataList = service.getDataList();
        int totalCases = dataList.stream().mapToInt(LocationStat::getTotalCases).sum();
        int totalDeaths = dataList.stream().mapToInt(LocationStat::getTotalDeaths).sum();
        int totalRecovers = dataList.stream().mapToInt(LocationStat::getTotalRecovers).sum();
        int totalDiffFromPrevDay = dataList.stream().mapToInt(LocationStat::getDiffFromPrevDay).sum();

        CovidReponseModel response = new CovidReponseModel(dataList, totalCases, totalDeaths, totalRecovers,
                totalDiffFromPrevDay, new Date());

        return ResponseEntity.ok(response);
    }

}
