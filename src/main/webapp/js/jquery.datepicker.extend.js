(function( factory ) {
    if ( typeof define === 'function' && define.amd ) {
        // AMD. Register as an anonymous module.
        define([ '../jquery.ui.datepicker' ], factory );
    } else {
        // Browser globals
        factory( jQuery.datepicker );
    }
}(function( datepicker ) {
    datepicker.regional['ko-KR'] = {
        showOn : 'both'
        , buttonImage : '/img/common/calendar.gif'
        , dateFormat : 'yy-mm-dd'
        , changeYear : true
        , changeMonth : true
        , monthNames : ['01','02','03','04','05','06','07','08','09','10','11','12']
        , monthNamesShort : ['01','02','03','04','05','06','07','08','09','10','11','12']
        , dayNames : ['S', 'M', 'T', 'W', 'T', 'F', 'S']
        , dayNamesShort : ['S', 'M', 'T', 'W', 'T', 'F', 'S']
        , dayNamesMin : ['S', 'M', 'T', 'W', 'T', 'F', 'S']
        , firstDay : 1
        , isRTL : false
        , showMonthAfterYear: true
        , nextText :'next'
        , prevText :'prev'
    };
    datepicker.setDefaults(datepicker.regional['ko-KR']);
    return datepicker.regional['ko-KR'];
}));

var _$datepicker = $('.datepicker');
if(_$datepicker){
    _$datepicker.each(function(){
        var $this = $(this);
        var datepicker_year_month_default = {
            dateFormat : 'yy-mm'
            , closeText : 'select'
            , 
        }
        if ($this.hasClass('start')||$this.hasClass('end')){
            $this.datepicker({
                onSelect : function(selectedDate){
                    var option = $this.hasClass('start') ? 'minDate' : 'maxDate'
                        , instance = $(this).data('datepicker')
                        , date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
                    
                    var _$siblings = $this.siblings('.' + ($this.hasClass('start') ? 'end' : 'start'));
                    if (_$siblings.length == 0) {
                    	_$siblings = $this.parents('div.form-group').siblings('div.form-group').find('.' + ($this.hasClass('start') ? 'end' : 'start'))
                    }
                    _$siblings.datepicker('option', option, date);
                }
            });
        }else{
            $this.datepicker();
        }
    });
};

var _$datepickerYearMonth = $('.datepicker-year-month');
if(_$datepickerYearMonth){
    _$datepickerYearMonth.each(function(){
        var $this = $(this);
        var datepicker_year_month_default = {
            dateFormat : 'yy-mm'
            , closeText : 'select'
            , showButtonPanel : true
            , showCalender : false
            , onClose : function (dateText, inst){
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val()
                    , month = $("#ui-datepicker-div .ui-datepicker-month :selected").val()
                    , date = new Date(year, month, 1);
                $this.datepicker('setDate', date)
            }
            , beforeShow : function(){
                var selectDate = $this.val().split("-")
                    , year = Number(selectDate[0])
                    , month = Number(selectDate[1]) - 1
                    , date = new Date(year, month, 1);
                $this.datepicker( "option", "defaultDate", date);
                $this.datepicker('setDate', date)
            }
        }
        $this.datepicker(datepicker_year_month_default);
    });
};