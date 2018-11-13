/*
 * jQuery XML Extension plugin - xmlprocess
 * Version 1.2 Beta (21. 07. 2017)
 * by weggles
 *
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 */

(function($) {
    $.fn.extend(jQuery, {
        postXmlAjax : function(requestUrl, requestXml ,callback){
            try {
                    $.ajax({
                       type: "POST",
                       dataType: 'xml',
                       url:  requestUrl,
                       data: requestXml,
                       async: true,
                       success: function(responseXml){
                            callback(responseXml);
                       },
                       error   : function(result){ alert( 'An error occurred.' );}
                    });
                } catch (e) {
                    alert("[AJAX ERROR] " + e.message);
                }
        }
    }); 
})(jQuery);