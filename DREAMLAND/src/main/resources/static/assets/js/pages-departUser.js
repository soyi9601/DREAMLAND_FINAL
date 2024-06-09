/**
 * 작성자 : 이소이
 * 기능   : jstree 조직도 구현, 노드 클릭 시 폼 입력
 * 이력   :
 *    1) 240605
 *        - 유저 조직도 커스텀
 */
  
  
/* *********** 유저 조직도 커스텀 *********** */
OrgChart.templates.myTemplate = Object.assign({}, OrgChart.templates.ana);
OrgChart.templates.myTemplate.size = [140, 60];
OrgChart.templates.myTemplate.node = '<rect x="0" y="0" height="60" width="140" fill="#90B54C" stroke-width="1" stroke="#fff" rx="5" ry="5"></rect>';
OrgChart.templates.myTemplate.field_0 = '<text data-width="140" class="field_0" style="font-size: 18px;" fill="#fff" x="71" y="34" text-anchor="middle">{val}</text>';
OrgChart.templates.myTemplate.plus = '<circle cx="15" cy="15" r="12" fill="#fff" stroke="#90B54C" stroke-width="1"></circle>'
    + '<line x1="10" y1="15" x2="20" y2="15" stroke-width="1" stroke="#444"></line>'
    + '<line x1="15" y1="10" x2="15" y2="20" stroke-width="1" stroke="#444"></line>';
OrgChart.templates.myTemplate.minus = '<circle cx="15" cy="15" r="12" fill="#fff" stroke="#90B54C" stroke-width="1"></circle>'
    + '<line x1="10" y1="15" x2="20" y2="15" stroke-width="1" stroke="#444"></line>';
OrgChart.templates.myTemplate.link =
    '<path stroke-linejoin="round" stroke="#afafaf" stroke-width="2px" fill="none" d="M{xa},{ya} {xb},{yb} {xc},{yc} L{xd},{yd}" />';

OrgChart.templates.employees = Object.assign({}, OrgChart.templates.myTemplate);
OrgChart.templates.employees.node = '<rect x="0" y="0" height="60" width="140" fill="#fff" stroke-width="2" stroke="#90B54C" rx="5" ry="5"></rect>';
OrgChart.templates.employees.field_0 = '<text data-width="140" class="field_0" style="font-size: 18px;" fill="#444" x="71" y="34" text-anchor="middle">{val}</text>';


  console.log(orgChartData);
  
  var chart = new OrgChart(document.getElementById('tree'), {
    template: 'myTemplate',    
    mouseScroll: OrgChart.none,
    layout: OrgChart.mixed,
    enableSearch: false,
    enableDragDrop: false,
    nodeBinding: {
      field_0: 'name',
    },
    tags: {
      employees: {
        template: "employees"
      },
    },
    nodes: orgChartData
  });

  chart.load(orgChartData); 

