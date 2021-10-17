<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhotoIn.aspx.cs" Inherits="Guest_PhotoIn" %>
<%@ OutputCache duration="10" varybyparam="None" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title></title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="Image Gallery with jQuery" />

    <link href="Gallery/css/elastislide.css" rel="stylesheet" />
    <noscript>
        <style>
            .es-carousel ul {
                display: block;
            }
        </style>
    </noscript>
    <script src="Gallery/js/jquery-1.10.1.min.js"></script>
    <script src="Gallery/js/jquery.easing.1.3.js"></script>
    <script src="Gallery/js/jquery.elastislide.js"></script>
    <script src="Gallery/js/jquery.tmpl.min.js"></script>
    <script src="Gallery/js/gallery.js"></script>

    <script id="img-wrapper-tmpl" type="text/x-jquery-tmpl">
        <div class="rg-image-wrapper">
            {{if itemsCount > 1}}
					<div class="rg-image-nav">
                        <a href="#" class="rg-image-nav-prev">&nbsp;</a>
                        <a href="#" class="rg-image-nav-next">&nbsp;</a>
                    </div>
            {{/if}}
				<div class="rg-image"></div>
            <div class="rg-loading"></div>
            <div class="rg-caption-wrapper">
                <div class="rg-caption" style="display: none;">
                    <p></p>
                </div>
            </div>
        </div>
    </script>
</head>
<body style="background-image: none !important;">
    <form id="form1" runat="server">
        <div class="container">
            <!-- header -->

            <div class="content2">
                <div id="rg-gallery">
                    <div class="rg-thumbs">
                        <!-- Elastislide Carousel Thumbnail Viewer -->
                        <div class="es-carousel-wrapper">
                            <div class="es-nav">
                                <span class="es-nav-prev">&nbsp;</span>
                                <span class="es-nav-next">&nbsp;</span>
                            </div>
                            <div class="es-carousel">
                                <ul id="imagecontainer" runat="server">
                                </ul>
                            </div>
                        </div>
                        <!-- End Elastislide Carousel Thumbnail Viewer -->
                    </div>
                    <!-- rg-thumbs -->
                </div>
                <!-- rg-gallery -->
            </div>
            <!-- content -->
        </div>
        <!-- container -->
    </form>
</body>
</html>
