<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var jumin = (function(un){
	var isF = function(f){return typeof(f)==='function';},
		pad = function(n,c,i){var j=i;while(i--){n=c+''+n;}return n.slice(-j);},
		random = {
			year:function(){var cyear=new Date().getFullYear();return ~~Math.min(Math.random()*(cyear-1900)+1900, cyear);},
			month:function(){var max=12;return ~~Math.min(Math.random()*max+1, max);},
			day:function(){var max=31;return ~~Math.min(Math.random()*max+1, max);},
			gender:function(){var max=2;return ~~Math.min(Math.random()*max+1, max);}
		},
		last = function(){
			var a = [].slice.call(arguments);
			var lm = 11-((a[0]*2+a[1]*3+a[2]*4+a[3]*5+a[4]*6+a[5]*7+a[6]*8+a[7]*9+a[8]*2+a[9]*3+a[10]*4+a[11]*5)%11);
			return lm>9 ? lm : lm % 10;
		},
		back = function(){
			var a = [].slice.call(arguments);
			for(var i=0;i<5;i++){a.push(~~Math.min(Math.random()*10,9));}
			return a[6]*1000000+a[7]*100000+a[8]*10000+a[9]*1000+a[10]*100+a[11]*10+last.apply(null, a);
		},
		jumin = function(options){
			options = options || {};
			var result = [];
			
			for(var i=0, loop = options.loop || 1; i < loop; i++){
				var year = isF(options.year) ? options.year() : options.year || random.year(), month = isF(options.month) ? options.month() : options.month || random.month(), day = isF(options.day) ? options.day() : options.day || random.day(), gender = isF(options.gender) ? options.gender() : options.gender || random.gender(), date = new Date(year, month - 1, day), ju = [];
				year = date.getFullYear();month = date.getMonth() + 1;day = date.getDate();
				ju.push((''+year+pad(month,'0',2)+pad(day,'0',2)).substring(2));
				ju.push(back.apply(null, ju[0].split('').concat([gender+(year>1999?2:0)])));
				result.push(ju.join('-'));
		   }
		   return result;
		};
	jumin.verify = function(ap, di){
		if(!ap){
			console.error('no arguments.');
			return false;
		}
		if(di){
			ap += '' + di;
		}
		ap = (ap+'').replace('-','');
		if(ap.length!=13){
			console.error('not vaild length.');
			return false;
		}
		var ju = ap.split(''),dt = new Date((+ju[6]>2?'20':'19')+ap.substring(0,2), +ap.substring(2,4)-1, ap.substring(4,6));
		if(ap.substring(0,6)!=(''+dt.getFullYear()+pad(dt.getMonth()+1,'0',2)+pad(dt.getDate(),'0',2)).substring(2)){
			console.error('not vaild date (yyMMdd).');
			return false;
		}
		if(ju[12]!=last.apply(null, ju)){
			console.error('not vaild ssn (last number not match).');
			return false;
		}
		return true;
	}
	/*
	 * 사용예) jumin({year:1990, month:3, day: 12, loop: 2})
	 * 확인예) jumin.verify(확인할 주민번호)
	 */
	alert(jumin({year:1999, month:1, day: 1, loop: 10}))
})();
</script>
</head>
<body>
</body>
</html>