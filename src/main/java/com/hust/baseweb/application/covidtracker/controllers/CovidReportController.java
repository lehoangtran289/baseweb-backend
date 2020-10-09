package com.hust.baseweb.application.covidtracker.controllers;

import com.hust.baseweb.application.covidtracker.models.CovidReponseModel;
import com.hust.baseweb.application.covidtracker.models.LocationStat;
import com.hust.baseweb.application.covidtracker.services.CovidDataService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

@RestController
@Log4j2
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class CovidReportController {

    private CovidDataService service;

    @GetMapping("/covid/data-list")
    public ResponseEntity<?> getCovidData(Pageable pageable) {
        List<LocationStat> dataList = service.getDataList();

        // convert datalist to pageable Page
        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), dataList.size());
        for (Sort.Order order : pageable.getSort()) {
            if (order.getDirection().isDescending()) {
                if (order.getProperty().equals("totalCases"))
                    dataList.sort(Comparator.comparing(LocationStat::getTotalCases).reversed());
                else if (order.getProperty().equals("totalDeaths"))
                    dataList.sort(Comparator.comparing(LocationStat::getTotalDeaths).reversed());
                else if (order.getProperty().equals("totalRecovers"))
                    dataList.sort(Comparator.comparing(LocationStat::getTotalRecovers).reversed());
            }
            if (order.getDirection().isAscending()) {
                if (order.getProperty().equals("totalCases"))
                    dataList.sort(Comparator.comparing(LocationStat::getTotalCases));
                else if (order.getProperty().equals("totalDeaths"))
                    dataList.sort(Comparator.comparing(LocationStat::getTotalDeaths));
                else if (order.getProperty().equals("totalRecovers"))
                    dataList.sort(Comparator.comparing(LocationStat::getTotalRecovers));
            }
        }
        Page<LocationStat> page = new PageImpl<>(dataList.subList(start, end), pageable, dataList.size());
        return ResponseEntity.ok(page);
    }

    @GetMapping("/covid/data-general")
    public ResponseEntity<?> getGeneralData() {
        List<LocationStat> dataList = service.getDataList();
        int totalCases = dataList.stream().mapToInt(LocationStat::getTotalCases).sum();
        int totalDeaths = dataList.stream().mapToInt(LocationStat::getTotalDeaths).sum();
        int totalRecovers = dataList.stream().mapToInt(LocationStat::getTotalRecovers).sum();
        int totalDiffFromPrevDay = dataList.stream().mapToInt(LocationStat::getDiffFromPrevDay).sum();

        CovidReponseModel response = new CovidReponseModel(totalCases, totalDeaths, totalRecovers,
                totalDiffFromPrevDay, new Date());
        return ResponseEntity.ok(response);
    }

}
