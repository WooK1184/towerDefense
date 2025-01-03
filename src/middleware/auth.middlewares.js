//====================================================================================================================
//====================================================================================================================
// src/middlewares/auth.middleware.js
// 인증 미들웨어
//====================================================================================================================
//====================================================================================================================
import jwt from 'jsonwebtoken';
import { prisma } from '../utils/prisma_client.js'
//import { prisma } from '../utils/prisma/index.js';
import dotenv from 'dotenv';

dotenv.config();

export default async function (req, res, next) {
    /* TODO */
    try {
        const { authorization } = req.cookies;
        if (!authorization){
            console.log("토큰이 존재하지 않습니다.") 
            throw new Error('토큰이 존재하지 않습니다.')};

        const [tokenType, token] = authorization.split(' ');


        if (tokenType !== 'Bearer')
        {
            console.log("토큰 타입이 존재하지 않습니다.") 
            throw new Error('토큰 타입이 일치하지 않습니다.');
        }

        const decodedToken = jwt.verify(token, process.env.JSONWEBTOKEN_KEY);
        const id = decodedToken.userId;

        

        console.log(decodedToken);
        console.log(id);
        
        const user = await prisma.uSERS.findFirst({
            where: { USER_ID: id },
        });

        console.log(user.USER_ID);

        if (!user) {
            res.clearCookie('authorization');
            console.log("토큰 사용자가 존재하지 않습니다.")
            throw new Error('토큰 사용자가 존재하지 않습니다.');
        }



        // req.user에 사용자 정보를 저장합니다.
        req.user = user;    
    

        next();
    } catch (error) {
        res.clearCookie('authorization');

        // 토큰이 만료되었거나, 조작되었을 때, 에러 메시지를 다르게 출력합니다.
        switch (error.name) {
            case 'TokenExpiredError':
                return res.status(401).json({ message: '토큰이 만료되었습니다.' });
            case 'JsonWebTokenError':
                return res.status(401).json({ message: '토큰이 조작되었습니다.' });
            default:
                return res
                    .status(401)
                    .json({ message: error.message ?? '비정상적인 요청입니다.' });
        }
    }
}