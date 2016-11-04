$( document ).ready(function() {
  $('#calendar').fullCalendar({
    header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,listYear'
    },
    events: '/events.json'
  });
});
