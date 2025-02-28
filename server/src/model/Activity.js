import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Board } from './Board';

@Entity()
export class Activity {
    @PrimaryGeneratedColumn('increment', { type: 'int' })
    id;

    @Column({ name: 'content', type: 'varchar' })
    content;

    @ManyToOne(() => Board, (board) => board.activities, { nullable: false })
    @JoinColumn({ name: 'board_id' })
    board;
}
