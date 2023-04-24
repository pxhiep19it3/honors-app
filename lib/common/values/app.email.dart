const emailTemplate = r"""
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Pangolin&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Work+Sans&display=swap');

        .container {
            width: 60%;
            /* padding: 20px; */
            color: #243040;
            margin: auto;
            /* font-family: 'Work Sans', sans-serif; */
            word-spacing: 2px;
            box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 5px 0px,
                rgba(0, 0, 0, 0.1) 0px 0px 1px 0px !important;
        }

        h1,
        h3,
        h2,
        h4 {
            text-align: center;
            color: #23326D
        }

        h1 {
            color: #26346D;
            /* font-family: "Roboto", cursive; */
            letter-spacing: 1px;
        }

        p:not(.footer),
        li {
            text-align: justify;
            color: #243040 !important;
        }

        p.footer {
            color: #243040;
            font-style: italic;
            text-align: center;
            font-size: 11px;
        }

        .section {
            margin: 10px 0;
            padding: 20px;
            background: #fff;
            border-radius: 6px;
        }

        .notice {
            border: 1px solid #23326D;
            background: none;
        }

        .section.notice li {
            margin: 0 auto;
            padding: 0;
        }

        .customer-info {
            margin-top: 10px;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            /* display: grid;
        grid-template-columns: 1fr 1fr ;
        grid-gap: 16px ; */
        }

        .customer-info div {
            flex: 50%
        }

        .col-second {
            padding-left: 20px;
        }

        .general h4 {
            text-align: center;
            margin: 0;
            margin-top: 10px;
        }

        .customer-seats {
            margin: 40px 0;
        }

        table tr th,
        table tr td {
            background: none;
            padding: 6px 10px;
            vertical-align: middle;
            text-align: center;
        }
 
        table {
            background: rgba(255, 255, 255, 0.6);
            width: 100%;
            border-collapse: collapse;
        }

        .notice h4 {
            color: #d47474;
        }

        ul {
            list-style-type: none;
            text-align: justify;
            margin-block-start: unset !important;
            margin-inline-start: unset !important;
            padding-inline-start: unset !important;
        }

        .img-responsive-qr {
            width: 250px;
        }

        .qr-code-container {
            margin-top: 32px;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
        }

        .qr-content {
            text-align: left;
        }

        .container-logo {
            padding-top: 32px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: row;
        }

        /* .container-logo {
    padding: 0;
    box-sizing: border-box;
    color: #303030;
    border: none;
    font-weight: bold;
    outline: none;
    text-decoration: none;
    text-transform: capitalize;
    font-size: 14px;
    line-height: 24px;
    height: auto;
    object-fit: cover;
    object-position: center;
    width: 100px;
    margin: 0 auto;
    display: block;
} */

        .logo {
            width: 200px;
            padding: 0;
            box-sizing: border-box;
            color: #303030;
            border: none;
            font-weight: bold;
            outline: none;
            text-decoration: none;
            text-transform: capitalize;
            font-size: 14px;
            line-height: 24px;
            height: auto;
            object-fit: cover;
            object-position: center;
            width: 100px;
            margin: 0 auto;
            display: block;
        }



        @media screen and (max-width: 600px) {
            .container {
                width: 100%;
            }

            .customer-info {
                /* grid-template-columns: 1fr; */
                flex-direction: column;
            }

            .qr-code-container {
                margin-top: 32px;
                display: block;
            }

            .img-responsive-qr {
                width: 250px;
                display: block;
                margin: 0 auto;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="container-logo">
            <img class="logo" src="https://udoo.work/wp-content/uploads/2021/03/cropped-LogoTrans.png">
        </div>
        <h2>LỜI MỜI THAM GIA WORKSPACE</h2>
        <div class="section welcome">
            <p>Xin chào {member_email},</p>
            <p>Bạn có lời mời tham gia vào workspace vinh danh.</p>

        </div>
        <div class="section general">
            <h2>THÔNG TIN</h2>
            <div class="customer-info">
                <div>
                    <p>Công ty: {company_name}</p>
                    <p>Người mời tham gia: {company_email}</p>
                </div>
            </div>
            <h2>Ấn vào đây để tham gia</h2>
            <div class="customer-info">
                <div style=" display: flex; justify-content: center">
                <!-- <a style="justify-content: center; text-align: center; font-size: 14px; background-color: #4B154B; padding: 12px; border-radius: 8px; color: white;" href="{link}">Tham gia</a> -->
                <img width="270", height="50" src="https://taxisaomai.vn/wp-content/uploads/2017/04/app-store-android-download.png">
                <br>
                <img width="270", height="50" src="https://giaohangtietkiem.vn/wp-content/uploads/2016/12/appstore.png">
            </div>
            </div>
        </div>

</body>
</html>
""";
