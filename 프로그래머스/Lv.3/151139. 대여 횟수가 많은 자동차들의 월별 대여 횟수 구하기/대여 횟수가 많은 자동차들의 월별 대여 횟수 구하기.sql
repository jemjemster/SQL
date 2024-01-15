/* 
 1. 대여 시작일을 기준 22.8월~22.10월 총 대여 횟수가 5회 이상인 자동차ID들 출력
 1.1 "총 대여 횟수가 5회 이상인 자동차들" -> 자동차ID만 그룹화 하여 대여 횟수
 1.2 "대여 시작일을 기준으로 22.8월~22.10월" -> 날짜 필터링
 
 2. 대여 시작일을 기준으로 22.8월~22.10월 월별, 자동차 ID 별 총 대여 횟수 출력
 2-2. "총 대여 횟수가 5회 이상인 자동차들에 대해서" -> 1번 테이블의 자동차 ID로 필터링 
 2-3. "월별, 자동차 ID 별 총 대여 횟수 출력" -> 월별 그룹화 & 자동차ID 그룹화 하여 대여 횟수
 2-4. "해당 기간 동안의" -> 날짜 필터링, 1번 테이블에서 넘겨받은 정보는 자동차 ID 뿐이므로 그걸로만 테이블에서 필터링시 08~10월이 아닌 경우도 남아있기 때문에 날짜 필터링을 다시 해줘야 한다.
 2-5. ** 서브쿼리로 나눠 처리해야하는 이유: (자동차ID)로 그룹화, (월별 그룹화 and 자동차ID) 그룹화의 결과값이 다르기 때문에 한 번에 처리가 불가하다.

*/


WITH CAR AS (
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
    WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
    GROUP BY CAR_ID
    HAVING COUNT(CAR_ID) >= 5
)

SELECT MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(CAR_ID) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
AND CAR_ID IN (SELECT * FROM CAR)
GROUP BY MONTH, CAR_ID
ORDER BY MONTH, CAR_ID DESC;