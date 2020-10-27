<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <title>Document</title>
    <style>
        .basicdiv{
            border: 1px black solid;
            width: 100%;
            height: 350px;
        }
        .inlinediv{
            border: 1px black solid;
            display: inline-block;
            width: 49%;
            height: 350px;
        }
        .rowName{
            width: 40%;
            height: 20%;
            font-weight: 700;
            text-align: center;
        }
        .rowData{
            width: 50%;
            height: 20%;

            text-align: center;
        }
    </style>
</head>

<body>
    <input type="hidden" id="cdata1" name="cdata1" value="{{cdata1}}">
    <input type="hidden" id="cdata2" name="cdata2" value="{{cdata2}}">
    <input type="hidden" id="cdata3" name="cdata3" value="{{cdata3}}">
    <input type="hidden" id="cdata4" name="cdata4" value="{{cdata4}}">
    <input type="hidden" id="cdata5" name="cdata5" value="{{cdata5}}">
    <h2>파이썬 크롤링을 이용해서 코로나 확진자수 파악하고 다양한 차트로 표현하기</h2>
    <div class="collapse navbar-collapse" id="one">
        <button><a href="#" id="onePage">page 1</a></button>
        <button><a href="#" id="twoPage">page 2</a></button>
        <button><a href="#" id="threePage">page 3</a></button>
        <button><a href="#" id="fourPage">page 4</a></button>
    </div>
    <div class="basicdiv" id="container"></div></br>
    <div class="inlinediv" id="container2"></div>
    <div class="inlinediv" style="float: right;">
        <h2 style="text-align: center;">코로나 발생동향입니다-그리드</h2>
        <table border="1px" style="margin: auto auto; height: 100px;">
            <tr>
                <td class="rowName">신규확진자</td>
                <td class="rowData">{{cdata1}}</td>
            </tr>
            <tr>
                <td class="rowName">치료중</td>
                <td class="rowData">{{cdata2}}</td>
            </tr>
            <tr>
                <td class="rowName">완치(격리해제)</td>
                <td class="rowData">{{cdata3}}</td>
            </tr>
            <tr>
                <td class="rowName">사망자</td>
                <td class="rowData">{{cdata4}}</td>
            </tr>
            <tr style="background-color: lightslategrey; font-weight: 700;">
                <td class="rowName">확진환자</td>
                <td class="rowData">{{cdata5}}</td>
            </tr>
        </table>
        </br>
        </br>
        <div style="margin-left: 20px;">
            <p>대한민국의 총 확진자수는 {{cdata5}}명 입니다</p>
            <small>※ 총 확진자수는 당일 발생한 신규 확진자수가 포함되어있지 않습니다.</small></br>
            <small>※ 총 확진자수 = 치료중 + 완치(격리해제) + 사망자</small>
        </div>
    </div>
</body>
<script>
    var today = new Date();
    var buf = "";
    buf += today.getFullYear() + "년 ";
    buf += (today.getMonth() + 1) + "월 ";
    buf += today.getDate() + "일 ";

    cdata1 = document.getElementById("cdata1").value
    cdata2 = document.getElementById("cdata2").value
    cdata3 = document.getElementById("cdata3").value
    cdata4 = document.getElementById("cdata4").value
    cdata5 = document.getElementById("cdata5").value

    cdata1 = parseInt(cdata1.replace(',', ''))
    cdata2 = parseInt(cdata2.replace(',', ''))
    cdata3 = parseInt(cdata3.replace(',', ''))
    cdata4 = parseInt(cdata4.replace(',', ''))
    cdata5 = parseInt(cdata5.replace(',', ''))
    total = cdata1 + cdata2 + cdata3 + cdata4
    console.log(total, cdata1, cdata2, cdata3, cdata4)
   
    Highcharts.chart('container', {
        chart: {
            type: 'bar'
        },
        title: {
            text: '<span style="font-size:20px; font-weight:700;">'+ buf + '</span> 코로나 발생 동향입니다 - 막대차트'
        },
        xAxis: {
            categories: ['신규', '치료중', '완치', '사망'],
            title: {
                text: null
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Population (millions)',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: '명'
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        credits: {
            enabled: false
        },
        series: [{
            name: buf,
            data: [cdata1, cdata2, cdata3, cdata4]
        }]
    });

    Highcharts.chart('container2', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text:'코로나 발생 동향입니다 - 파이차트'
        },
        tooltip: {
            pointFormat: '<b>{point.percentage:.1f}%</b>'
        },
        accessibility: {
            point: {
                valueSuffix: '%'
            }
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: [{
                name: '신규확진자',
                y: cdata1 / total
            }, {
                name: '치료중(격리중)',
                y: cdata2 / total
            }, {
                name: '완치(격리해제)',
                y: cdata3 / total
            }, {
                name: '사망',
                y: cdata4 / total
            }]
        }]
    });

</script>

</html>