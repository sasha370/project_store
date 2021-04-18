	$(document).ready(function(){
		    // $('#quantity').prop('disabled', true);
   			$(document).on('click','#quantity_plus',function(){
				$('#quantity').val(parseInt($('#quantity').val()) + 1 );
    		});
        	$(document).on('click','#quantity_minus',function(){
    			$('#quantity').val(parseInt($('#quantity').val()) - 1 );
    				if ($('#quantity').val() == 0) {
						$('#quantity').val(1);
					}
    	    	});
 		});
