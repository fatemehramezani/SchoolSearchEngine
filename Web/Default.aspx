<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<%--<%@ OutputCache Duration="10" VaryByParam="None" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery.matchHeight/0.7.0/jquery.matchHeight-min.js"></script>
    <script src="Script/Common/default.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="Server">
    <!-- TOP SLIDER -->
    <ul class="anim-slider">
        <!-- Slide No1 -->
        <li class="anim-slide">
            <img src="App_Themes/Default/slider/images/5.png" class="hidden-sm hidden-xs" alt="مدرسه">
            <h1 id="slider">جستجوی هوشمندانه مدارس کشور</h1>
            <h2 id="plugin">مدارس غیرانتفاعی و هیات امنایی</h2>
            <h3 id="license">مدارس دخترانه و پسرانه</h3>
            <h4 id="version">مدارس آموزش از راه دور و غیرحضوری</h4>
        </li>

        <!-- Slide No2 -->
        <li class="anim-slide">
            <h3 id="todo">شما چه معیارهایی برای انتخاب مدرسه فرزندتان دارید؟</h3>

            <h3 id="bounce">امکانات</h3>
            <h4 id="bounceUp">کادر آموزشی</h4>
            <h4 id="bounceRight">تجهیزات آزمایشگاهی</h4>

            <h3 id="fade">فاصله تا خانه</h3>
            <h4 id="fadeUp">آمار قبولی دانشگاه</h4>
            <h4 id="fadeDown">معلمان و اساتید با تجربه</h4>

            <h3 id="rotate">کلاسهای فوق برنامه</h3>
            <h4 id="rotateRight">محیط پر انگیزه و انگیزشی</h4>
            <h3 id="rotateLeft">برترینهای المپیاد و مسابقات علمی</h3>
        </li>
        <!-- Slide No3 -->
        <li class="anim-slide">
            <img src="App_Themes/Default/slider/images/6.png" alt="CSS3" id="css3">            
            <img src="App_Themes/Default/slider/images/7.png" alt="jQuery" id="jquery">
            <img src="App_Themes/Default/slider/images/8.png" alt="HTML5" id="html5">
            <img src="App_Themes/Default/slider/images/1.png" alt="Modernizr" id="modernizr">
            <h2 id="animatecss">بهترین مدارس ایران</h2>
        </li>
        <!-- Arrows -->
        <nav class="anim-arrows">
            <span class="anim-arrows-prev"></span>
            <span class="anim-arrows-next"></span>
        </nav>
        <!-- Dynamically created dots -->
    </ul>
    <link rel="stylesheet" href="App_Themes/Default/slider/css/jquery.animateSlider.css">
    <link rel="stylesheet" href="App_Themes/Default/slider/css/font-awesome.css">
    <link rel="stylesheet" href="App_Themes/Default/slider/css/normalize.css">
    <link rel="stylesheet" href="App_Themes/Default/slider/css/demo1.css">
    <script src="App_Themes/Default/slider/js/jquery.min.js"></script>
    <script src="App_Themes/Default/slider/js/modernizr.js"></script>
    <script src="App_Themes/Default/slider/js/jquery.animateSlider.js"></script>
    <script>
		 $(".anim-slider").animateSlider(
		 	{
		 		autoplay	:true,
		 		interval	:5000,
		 		animations 	:
				{
					0	: 	//Slide No1
					{
						h1	:
						{
							show   	  : "bounceIn",
							hide 	  : "flipOutX",
							delayShow : "delay1s"
	 					},
	 					h2:
	 					{
	 						show 	  : "fadeInUpBig",
							hide 	  : "fadeOutDownBig",
							delayShow : "delay1-5s"
	 					},
	 					h3 	:
	 					{
							show   	  : "bounceInRight",
							hide 	  : "fadeOutRightBig",
							delayShow : "delay1-5s"
	 					},
	 					h4:
	 					{
	 						show 	  : "bounceInUp",
							hide 	  : "fadeOutLeftBig",
							delayShow : "delay2s"
						}
					},
					1	: //Slide No2
					{
						"#todo":
						{
							show 		: "fadeIn",
							hide 		: "fadeOut",
							delayShow   : "delay0-5s"
						},
						"#bounce" 	:
						{
							show 	 	: "bounceIn",
							hide 	 	: "bounceOut",
							delayShow 	: "delay2s"
						},
						"#bounceUp":
						{
							show 	 	: "bounceInDown",
							hide 	 	: "bounceOutLeft",
							delayShow 	: "delay2-5s"
						},
						"#bounceRight":
						{
							show 	 	: "bounceInRight",
							hide 	 	: "bounceOutRight",
							delayShow 	: "delay3s"
						},
						"#fade" :
						{
							show 	 	: "fadeInLeft",
							hide 	 	: "fadeOutLeft",
							delayShow 	: "delay3-5s"
						},
						"#fadeUp":
						{
							show 	 	: "fadeInUpBig",
							hide 	 	: "fadeOutUpBig",
							delayShow 	: "delay4s"
						},
						"#fadeDown":
						{
							show 	 	: "fadeInDownBig",
							hide 	 	: "fadeOutDownBig",
							delayShow 	: "delay4-5s"
						},
						"#rotate" :
						{
							show 	 	: "rotateIn",
							hide 	 	: "rotateOut",
							delayShow 	: "delay5-5s"
						},
						"#rotateRight" :
						{
							show 	 	: "rotateInUpRight",
							hide 	 	: "rotateOutDownRight",
							delayShow 	: "delay6s"
						},
						"#rotateLeft" :
						{
							show 	 	: "rotateInUpLeft",
							hide 	 	: "rotateOutDownLeft",
							delayShow 	: "delay6-5s"
						}
					},
					2	: //Slide No3
					{
						"img#css3"	:
						{
							show 	  : "flipInY",
							hide 	  : "flipOutY",
							delayShow : "delay0-5s"
						},
						"img#html5"	:
						{
							show 	  : "flipInY",
							hide 	  : "flipOutY",
							delayShow : "delay0-5s"
						},
						"img#jquery"  :
						{
							show 	  : "bounceIn",
							hide 	  : "flipOutY",
							delayShow : "delay1-5s"
						},
						"img#modernizr" :
						{
							show 	  : "rollIn",
							hide 	  : "flipOutY",
							delayShow : "delay2s"
						},
						"#animatecss"	:
						{
							show 	  : "lightSpeedIn",
							hide 	  : "flipOutY",
							delayShow : "delay2-5s"
						}
					}
				}
		 	});
    </script>


    <!-- Filter -->
    <div class="row">
        <ul class="filtertab box">
            <li id="tuition" onclick='location.href="../../search/tuition=4-5"' title="میزان شهریه 4 تا 5 میلیون تومان">
                <a href="../../search/tuition=4-5">میزان شهریه</a>
            </li>
            <li id="girl" onclick='location.href="../../search/filterid=18' title="مدارس دخترانه">
                <a href="../../search/filterid=18">دخترانه</a>
            </li>
            <li id="boy" onclick='location.href="../../search/filterid=19' title="مدارس پسرانه">
                <a href="../../search/filterid=19">پسرانه</a>
            </li>
            <li id="first" onclick='location.href="../../search/filterid=43' title="دوره اول متوسطه">
                <a href="../../search/filterid=43">دوره اول</a>
            </li>
            <li id="second" onclick='location.href="../../search/filterid=44' title="دوره دوم متوسطه">
                <a href="../../search/filterid=44">دوره دوم</a>
            </li>
        </ul>
    </div>
    <div class="row hentry">
        <header class="entry-header">
            <h1 class="entry-title">
                <a href="مدرسه_یاب">
                <UserControl:DynamicPageItem ID="DefaultH1" runat="server" Name="DefaultH1"/>
                </a>
            </h1>
        </header>
    </div>
    <UserControl:SchoolFilter runat="server" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomContent" runat="Server">
    <div class="row hentry">
        <UserControl:DynamicPageItem runat="server" Name="DefaultDescription" />
    </div>
</asp:Content>

