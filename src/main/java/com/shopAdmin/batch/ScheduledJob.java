package com.shopAdmin.batch;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.shopAdmin.employee.service.EmployeeService;

@Component
public class ScheduledJob {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Resource(name="employeeService")
    private EmployeeService employeeService;
    
    /**********************************************************************************
     *  배치 목록
     * - 직원 급여 등록 : 매월 1일 12시 5분
     **********************************************************************************/
    
    /**
     * @packeName  : com.shopAdmin.batch
     * @fileName   : ScheduledJob.java
     * @methodName : employeeDesignerSalaryRegist
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원 급여 등록
     *
     * @throws Exception
     */
    @Scheduled(cron="0 5 0 1 * ?")
    public void employeeDesignerSalaryRegist () throws Exception {
        try {
            this.employeeService.insertEmployeeDesignerSalary();
        } catch (Exception e) {
            this.logger.error("================ 직원 급여 배치 ================");
            e.printStackTrace();
            this.logger.error("==============================================");
        }
    }
    
    @Scheduled(cron="0 3 0 1 * ?")
    public void employeeDesignerHolidayRegist () throws Exception {
        try {
            this.employeeService.mergeEmployeeRemainHoliday();
        } catch (Exception e) {
            this.logger.error("================ 직원 휴일 배치 ================");
            e.printStackTrace();
            this.logger.error("==============================================");
        }
    }
}
