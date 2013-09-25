(function ($) {

    function init_add_new_field_button(self) {
        self.find('.add_new_search_criteria').click(function() {
            var field_count = self.data("field_count") + 1;
            var klass = 'set' + field_count;
            var column = 'item_'+field_count+'_columns';
            var column_name = 'item['+field_count+'][columns]';
            var operand = 'item_'+field_count+'_operand';
            var operand_name = 'item['+field_count+'][operand]';
            var column_value = 'item_'+field_count+'_column_value';
            var column_value_name = 'item['+field_count+'][column_value]';
            var and_or = 'item_'+field_count+'_and_or_';
            var and_or_name = 'item['+field_count+'][and_or]'
            var html_str = "<div class='"+klass+"'>";
            html_str += "<select class='select65 marginright5' id='"+and_or+"' name='"+and_or_name+"'><option value='AND'>AND</option>";
            html_str += "<option value='OR'>OR</option></select>";
            html_str += "<select class='select140 marginright5' id='"+column+"' name='"+column_name+"'><option value='kind'>kind</option>";
            html_str += "<option value='height'>height</option>";
            html_str += "<option value='emergency_exit'>emergency_exit</option>";
            html_str += "<option value='openable'>openable</option></select>";
            html_str += "<select class='select65 marginright5' id='"+operand+"' name='"+operand_name+"'><option value='&gt;'>&gt;</option>";
            html_str += "<option value='&lt;'>&lt;</option>";
            html_str += "<option value='='>=</option>";
            html_str += "<option value='!='>!=</option></select>";
            html_str += "<input class='marginright5' type='text' id='"+column_value+"' name='"+column_value_name+"'>";
            html_str += "</div>";
            $('.search_form .btn_item_search').before($(html_str));
            self.data("field_count", field_count);
            return false;
        });
    }

    function init_delete_field_button(self) {
        self.find('.delete_search_criteria').click(function() {
            var field_count = self.data("field_count");
            if(field_count > 1){
                var klass = 'set' + self.data("field_count");
                $('.' + klass).remove();
                self.data("field_count", field_count - 1);
            }
            return false;
        });
    }

    function init_sorting(self) {
        $("#items th a, #items .pagination a").on("click", function() {
          $.getScript(this.href);
          return false;
        });
        $("#products_search input").keyup(function() {
          $.get($(".search_form").attr("action"), $(".search_form").serialize(), null, "script");
          return false;
        });
    }

    $.fn.items_search_form = function (options) {
        this.each(function () {
            var self = $(this);
            self.data("field_count", 1);
            init_add_new_field_button(self);
            init_delete_field_button(self);
            init_sorting(self);
        });
    };

})(jQuery);
