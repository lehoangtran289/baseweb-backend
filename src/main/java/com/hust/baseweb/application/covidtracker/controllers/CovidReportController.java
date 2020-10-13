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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@Log4j2
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class CovidReportController {

    private CovidDataService service;

    @GetMapping("/covid/data-list")
    public ResponseEntity<?> getCovidData(Pageable pageable, @RequestParam(required = false) String search) throws IOException {
        List<LocationStat> dataList = service.getDataListLatestDay();

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

        if (search != null && !search.isEmpty())
            dataList =
                    dataList.stream().filter(item -> item.getCountry().equals(search) || item.getState().equals(search)).collect(Collectors.toList());

        // convert datalist to pageable Page
        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), dataList.size());
        Page<LocationStat> page = new PageImpl<>(dataList.subList(start, end), pageable, dataList.size());

        return ResponseEntity.ok().body(page);
    }

    @GetMapping("/covid/data-last-nth-days")
    public ResponseEntity<?> getLast7DaysData(@RequestParam(defaultValue = "7") String days) throws IOException {
        return ResponseEntity.ok().body(service.getDataInMultipleDays(Integer.parseInt(days)));
    }

    @GetMapping("/covid/data-general")
    public ResponseEntity<?> getGeneralData() throws IOException {
        List<LocationStat> dataList = service.getDataListLatestDay();
        int totalCases = dataList.stream().mapToInt(LocationStat::getTotalCases).sum();
        int totalDeaths = dataList.stream().mapToInt(LocationStat::getTotalDeaths).sum();
        int totalRecovers = dataList.stream().mapToInt(LocationStat::getTotalRecovers).sum();
        int totalDiffFromPrevDay = dataList.stream().mapToInt(LocationStat::getDiffFromPrevDay).sum();

        CovidReponseModel response = new CovidReponseModel(totalCases, totalDeaths, totalRecovers,
                totalDiffFromPrevDay, LocalDate.now());
        return ResponseEntity.ok().body(response);
    }

}
